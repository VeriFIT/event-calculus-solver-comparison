#!/bin/bash

# takes replaces terms/atoms in the Answer by their corresponding interpreted values from the Assignment
# if there is no matching term/atom in the Answer for an Assignment, then it will stay as leftovers (will still be printed in the Assignment section)


LEFTOVERS=true
if [ $# -eq 1 ]; then
    LEFTOVERS=false
# else
#     echo "Usage: $0 [.*]"
#     exit 1
fi

MODE="Skip"
ANSW_HEAD=""

while IFS= read LINE
    do
        case "$LINE" in
            Answer:*)
                echo "$LINE"
                MODE="Answer"
                ;;
            Assignment:*)
                MODE="Assignment"
                ;;
            *)
                if [ $MODE = "Answer" ]; then
                    answer_AsLines=$(echo "$LINE" | sed 's|) |)\n|g')
                    MODE="Skip"
                elif [ $MODE = "Assignment" ]; then
                    assignment_AsLines=$(echo "$LINE" | sed 's|\([0-9]\) |\1\n|g')
                    newAnswer_AsLines=$(echo "$answer_AsLines")
                    leftoverAssignment=""
                    for assignment in $(echo "$assignment_AsLines"); do
                        name=$(echo "$assignment" | cut -d = -f 1)
                        value=$(echo "$assignment" | cut -d = -f 2)
                        if $LEFTOVERS; then 
                            # if this assignment is in the answer then replace it and dont include it in the assignment section, otherwise keep it there
                            if echo "$newAnswer_AsLines" | grep -q "$name"; then
                                newAnswer_AsLines=$(echo "$newAnswer_AsLines" | sed "s|$name|$value|g")
                            else
                                leftoverAssignment=$(echo $leftoverAssignment $assignment)
                            fi
                        else
                            newAnswer_AsLines=$(echo "$newAnswer_AsLines" | sed "s|$name|$value|g")
                            leftoverAssignment=$(echo $leftoverAssignment $assignment)
                        fi
                    done
                    newAnswer=$(echo $newAnswer_AsLines)
                    echo "$newAnswer"
                    if $LEFTOVERS; then 
                        # only print the assignment section if there are some leftover assignments 
                        if echo "$leftoverAssignment" | grep -q "="; then
                            echo "Assignment: [leftovers]"
                            echo "$leftoverAssignment"
                        fi
                    else
                            echo "Assignment:"
                            echo "$leftoverAssignment"
                    fi
                    MODE="Skip"
                else
                    echo "$LINE"
                fi
                ;;
        esac

	done
