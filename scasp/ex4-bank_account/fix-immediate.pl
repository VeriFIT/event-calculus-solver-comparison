% Bank account example
% from T.Mueller, 2014 - Commonsense reasoning - an event calculus based approach
% based on page 70, section 4.2

#show happens/2, not_happens/2.
#show holdsAt/2, not_holdsAt/2.
#show initiallyP/1, initiallyN/1.
#show stoppedIn/3, not_stoppedIn/3.
#show startedIn/3, not_startedIn/3.
#show initiates/3, terminates/3, releases/3.
#show trajectory/4.


%-------------------------------------------------------------------------------
% sorts
%-------------------------------------------------------------------------------

%% max_time(PARAMETER).     %% added on execution via an external file
endOfMonth(5).

account(account1).
account(account2).

fluent(balance(A, M)).
fluent(minimumBalance(A, M)).
fluent(serviceFee(A, M)).
fluent(serviceFeeCharged(A)).

event(transfer(A1, A2, M)).
event(chargeServiceFee(A)).
event(monthlyReset(A)).


%-------------------------------------------------------------------------------
% effects 
%-------------------------------------------------------------------------------

%% basic operation of the account -- next 4 rules
%% if balance of account A1 is greater equal to the amount to be transfered,
%% and the amount is transfered from A1 to account A2,
%% then the balance of A1 decreses and of A2 increases
% new balance of A2 (receives payment)
initiates(transfer(A1, A2, TransM12), balance(A2, SUM), T) :-
    TransM12 .>. 0,
    SrcM1 .>=. TransM12,
    SUM .=. DstM2 + TransM12,
    holdsAt(balance(A2, DstM2), T),
    holdsAt(balance(A1, SrcM1), T).
% terminate old balance of A2
terminates(transfer(A1, A2, TransM12), balance(A2, DstM2), T) :-
    TransM12 .>. 0,
    SrcM1 .>=. TransM12,
    holdsAt(balance(A2, DstM2), T),
    holdsAt(balance(A1, SrcM1), T).
% new balance of A1 (sends payment)
initiates(transfer(A1, A2, TransM12), balance(A1, SUM), T) :-
    not_happens(chargeServiceFee(A1), T),               % no effect when service at the same time
    TransM12 .>. 0,
    SrcM1 .>=. TransM12,
    SUM .=. SrcM1 - TransM12,
    holdsAt(balance(A2, DstM2), T),
    holdsAt(balance(A1, SrcM1), T).
% terminate old balance of A1
terminates(transfer(A1, A2, TransM12), balance(A1, SrcM1), T) :-
    not_happens(chargeServiceFee(A1), T),               % no effect when service at the same time
    TransM12 .>. 0,
    SrcM1 .>=. TransM12,
    holdsAt(balance(A2, DstM2), T),
    holdsAt(balance(A1, SrcM1), T).


% when a service fee is charged, then a note is made to avoid repeated charging
initiates(chargeServiceFee(A), serviceFeeCharged(A), T).
% this is reset every month
terminates(monthlyReset(A), serviceFeeCharged(A), T).

% if a service fee is charged, then the balance of the account is decreased
% new balance
initiates(chargeServiceFee(A), balance(A, SUM), T) :-   % bound to the transfer event
    happens(transfer(A, _, TransfM), T),
    SUM .=. OldM - (TransfM + FeeM),
    holdsAt(serviceFee(A, FeeM), T),
    holdsAt(balance(A, OldM), T).
initiates(chargeServiceFee(A), balance(A, SUM), T) :-   % bound to the monthly reset event
    happens(monthlyReset(A), T),
    SUM .=. OldM - FeeM,
    holdsAt(serviceFee(A, FeeM), T),
    holdsAt(balance(A, OldM), T).

% terminate old balance
terminates(chargeServiceFee(A), balance(A, OldM), T) :-
    holdsAt(balance(A, OldM), T).


%-------------------------------------------------------------------------------
% state constraints
%-------------------------------------------------------------------------------

% not needed ...


%-------------------------------------------------------------------------------
% triggered events
%-------------------------------------------------------------------------------

% if the balance of an account falls below the minimum
% and a service fee has not yet been charged
% then a service fee will be charged
happens(chargeServiceFee(A), T) :-    % bound to the transfer event
    happens(transfer(A, _, TransfM), T),
    holdsAt(minimumBalance(A, MinM), T),
    NewB .=. OldB - TransfM,
    NewB .<. MinM,
    not_holdsAt(serviceFeeCharged(A), T),
    holdsAt(balance(A,OldB), T).
happens(chargeServiceFee(A), T) :-    % bound to the monthly reset event
    happens(monthlyReset(A), T),
    holdsAt(minimumBalance(A, MinM), T),
    B .<. MinM,
    terminates(monthlyReset(A), serviceFeeCharged(A), T),
    holdsAt(balance(A,B), T).


% monthly reset of the service fee
happens(monthlyReset(A), T) :- endOfMonth(T).


%-------------------------------------------------------------------------------
% observations
%-------------------------------------------------------------------------------

initiallyP(balance(account1, 10)).      
initiallyP(balance(account2, 10)).      
initiallyP(minimumBalance(account1, 5)).
initiallyP(minimumBalance(account2, 5)).
initiallyP(serviceFee(account1, 1)).    
initiallyP(serviceFee(account2, 1)).    
initiallyN(F) :- not initiallyP(F).


%-------------------------------------------------------------------------------
% narrative 
%-------------------------------------------------------------------------------

happens(transfer(account1, account2, 2), 1).
happens(transfer(account1, account2, 4), 2).

% --> conclude that
%   a service fee is charged to account1 "in response to transfer at time 2" due to the balance being 4
%   the balance of account1 will be 3 at time 4
%   the service fee flag is reset at time 5
%   a service fee is again charged to account1 "in response to reset at time 5"
%   the balance of account1 will be 2 at time 7
?-  T1 .<. 4, happens(chargeServiceFee(account1), T1),
    holdsAt(balance(account1, B1), 4),
    happens(monthlyReset(account1), 5),
    T2 .>. T1, happens(chargeServiceFee(account1), T2),
    holdsAt(balance(account1, B2), 7).
