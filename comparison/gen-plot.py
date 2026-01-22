import argparse
import os
import pandas as pd
import matplotlib.pyplot as plt

# ---------- Compact style ----------
plt.rcParams.update({
    "font.size": 8,
    "axes.labelsize": 8,
    "axes.titlesize": 9,
    "legend.fontsize": 7,
    "xtick.labelsize": 7,
    "ytick.labelsize": 7,
})

FigSize = (3.9, 2.6)

# ---------- CSV loader ----------
def load_tool(path, fname, prefix):
    fullpath = os.path.join(path, fname)
    df = pd.read_csv(fullpath, sep=";", skipinitialspace=True)
    df.columns = df.columns.str.strip()
    df.rename(columns={
        "T [s]": f"{prefix}_T",
        "M [MB]": f"{prefix}_M",
        "RES": f"{prefix}_RES"
    }, inplace=True)
    return df

def main(data_dir, graph_name, LogScaleX, LogScaleY, Timeout):
    # Load and merge CSVs
    df = (
        load_tool(data_dir, "clingo.csv", "BASE")
        .merge(load_tool(data_dir, "clingcon.csv", "CON"),
               on=["NAME", "PARAM"], how="outer")
        .merge(load_tool(data_dir, "clingolpx.csv", "LPX"),
               on=["NAME", "PARAM"], how="outer")
    )

    # Convert numeric columns
    for c in ["BASE_T", "CON_T", "LPX_T",
              "BASE_M", "CON_M", "LPX_M"]:
        df[c] = pd.to_numeric(df[c], errors="coerce")

    tools = [
        ("BASE", "clingo", "tab:blue"),
        ("CON",  "clingcon", "tab:green"),
        ("LPX",  "clingolpx", "tab:orange"),
    ]
    
    toolLegendAndLines = {
        "clingo": {
            "P1"      : ("pT1", "tab:blue", "solid"),
            "P10"     : ("pT10", "tab:blue", "dashed"),
            "PT1-PV1" : ("pT1pV1", "tab:blue", "solid"),
            "PT1-PV4" : ("pT1pV4", "tab:blue", "dotted"),
            "PT4-PV1" : ("pT4pV1", "tab:blue", "dashed"),
            "PT4-PV4" : ("pT4pV4", "tab:blue", "dashdot")
        },
        "clingcon": {
            "P10" :      ("incr", "tab:green", "solid"),
            "know-P10" : ("guess", "tab:green", "dashed")
        },
        "clingolpx": {
            "P10" :      ("incr", "tab:orange", "solid"),
            "know-P10" : ("guess", "tab:orange", "dashed")
        },
    }

    # ================= FIGURE 1: Execution Time =================
    fig, ax = plt.subplots(figsize=FigSize)

    for prefix, toolname, color in tools:
        needGenericLegend=True
        for dataname, g in df.groupby("NAME"):
            if (g[f"{prefix}_T"].count() > 0 ):
                g = g.sort_values("PARAM")
                
                style = "solid"
                if dataname in toolLegendAndLines[toolname]:
                    label, color, style = toolLegendAndLines[toolname][dataname]
                    ax.plot([], [], color=color, label=toolname + "-" + label, linestyle=style)
                    needGenericLegend=False
                
                ax.plot(
                    g["PARAM"], g[f"{prefix}_T"],
                    color=color,
                    alpha=0.7,
                    linewidth=0.9,
                    linestyle=style
                )
        if (needGenericLegend == True):
          ax.plot([], [], color=color, label=toolname)  
            
    ## Legend (dummy lines)
    ##for _, label, color in tools:
    ##    ax.plot([], [], color=color, label=label)

    if (LogScaleX==True):
        ax.set_xscale("log")
    if (LogScaleY==True):
        ax.set_yscale("log")
    ax.set_xlim(df["PARAM"].min(), df["PARAM"].max())
    ax.axhline(Timeout, color="red", linestyle="--", linewidth=1)
    
    ax.set_xlabel(graph_name)
    ax.set_ylabel("Execution time (s)")
    ax.grid(True, which="both", linestyle="--",
            linewidth=0.4, alpha=0.5)
    
    ### legend in the graph
    ##ax.legend(frameon=False)
    ##fig.tight_layout(pad=0.4)
    
    # legend to the right
    ax.legend(
        frameon=False,
        loc="center left",
        bbox_to_anchor=(1.00, 0.5)
    )
    fig.tight_layout(pad=0.4, rect=[0, 0, 1, 1])

    # legend above in two columns
    #ax.legend(
    #    frameon=False,
    #    loc="lower center",
    #    bbox_to_anchor=(0.5, 1.02),
    #    ncol=2,
    #    columnspacing=0.8,
    #    handletextpad=0.4
    #)
    
    fig.savefig(os.path.join(data_dir, graph_name + "-execution_time_lines.pdf"))
    fig.savefig(os.path.join(data_dir, graph_name + "-execution_time_lines.png"), dpi=300)

    # ================= FIGURE 2: Memory Usage =================
    fig, ax = plt.subplots(figsize=FigSize)

    for prefix, _, color in tools:
        for _, g in df.groupby("NAME"):
            g = g.sort_values("PARAM")
            ax.plot(
                g["PARAM"], g[f"{prefix}_M"],
                color=color,
                alpha=0.5,
                linewidth=0.9
            )

    # Legend (dummy lines)
    for _, label, color in tools:
        ax.plot([], [], color=color, label=label)

    if (LogScaleX==True):
        ax.set_xscale("log")
    if (LogScaleY==True):
        ax.set_yscale("log")
    ax.set_xlim(df["PARAM"].min(), df["PARAM"].max())
    ax.set_xlabel(graph_name)
    ax.set_ylabel("Memory usage (MB)")
    ax.grid(True, which="both", linestyle="--",
            linewidth=0.4, alpha=0.5)
    ax.legend(frameon=False)

    fig.tight_layout(pad=0.4)
    fig.savefig(os.path.join(data_dir, graph_name + "-memory_usage_lines.pdf"))
    fig.savefig(os.path.join(data_dir, graph_name + "-memory_usage_lines.png"), dpi=300)

# ---------- CLI ----------
if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Plot execution time and memory usage vs PARAM"
    )
    parser.add_argument(
        "data_dir",
        help="Directory containing clingo.csv, clingcon.csv, clingolpx.csv"
    )
    parser.add_argument(
        "graph_name",
        help="Naming the output graphs"
    )
    parser.add_argument(
        "--logx",
        action='store_true',
        help="Set the X axis to logarithmic scale"
    )
    parser.add_argument(
        "--logy",
        action='store_true',
        help="Set the Y axis to logarithmic scale"
    )
    parser.add_argument(
        "--timeout",
        type=int,
        help="Value of the timeout for time measurements"
    )
    args = parser.parse_args()

    main(args.data_dir, args.graph_name, args.logx, args.logy, args.timeout)
