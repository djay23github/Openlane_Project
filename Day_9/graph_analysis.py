import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import os

os.makedirs("plots", exist_ok=True)

power_file = "power_summary.rpt"
timing_file = "timing_summary.rpt"

power_df = pd.read_csv(power_file, delim_whitespace=True, skiprows=1, names=["Process", "PVT Corner", "Total Power"])
power_df[["Process_Name", "Temp", "Voltage"]] = power_df["PVT Corner"].str.extract(r"(\w+)_([n\d]+)C_([\dv]+)")
power_df["Temp"] = power_df["Temp"].apply(lambda x: -int(x[1:]) if x.startswith("n") else int(x))
power_df["Voltage"] = power_df["Voltage"].str.replace("v", ".", regex=False).astype(float)
power_df = power_df[["Process", "PVT Corner", "Temp", "Voltage", "Total Power"]]
power_df = power_df.sort_values(by=["Process", "Temp", "Voltage"])

timing_df = pd.read_csv(timing_file, delim_whitespace=True, skiprows=1, names=["Process", "PVT Corner", "Path Type", "Slack", "Status"])
timing_df[["Process_Name", "Temp", "Voltage"]] = timing_df["PVT Corner"].str.extract(r"(\w+)_([n\d]+)C_([\dv]+)")
timing_df["Temp"] = timing_df["Temp"].apply(lambda x: -int(x[1:]) if x.startswith("n") else int(x))
timing_df["Voltage"] = timing_df["Voltage"].str.replace("v", ".", regex=False).astype(float)
timing_df = timing_df[["Process", "PVT Corner", "Temp", "Voltage", "Path Type", "Slack", "Status"]]
timing_df = timing_df.sort_values(by=["Process", "Path Type", "Temp", "Voltage"])


proc_color = {
    "TT": "steelblue",
    "FF": "tomato",
    "SS": "seagreen"
}


plt.figure(figsize=(10,8))

for proc in power_df["Process"].unique():
    subset = power_df[power_df["Process"] == proc]
    plt.plot(
        subset["PVT Corner"], subset["Total Power"],
        marker="o",
        color=proc_color.get(proc, "orange"),
        label=proc,
        linewidth=2
    )
    plt.xlabel("PVT Corner", fontsize=12)
    plt.ylabel("Total Power (W)", fontsize=12)
    plt.title("Power vs PVT Corner", fontsize=14, fontweight="bold")
    plt.xticks(rotation=45, ha="right")
    plt.grid(True, linestyle="--", alpha=0.6)
    plt.legend(title="Process")
    plt.tight_layout()
    plt.savefig("plots/Power_vs_PVT_Corner.png")


plt.figure(figsize=(10,8))
for proc in timing_df["Process"].unique():
    subset = timing_df[(timing_df["Process"] == proc) & (timing_df["Path Type"] == "hold")]
    plt.plot(
        subset["PVT Corner"], subset["Slack"],
        marker="*",
        linewidth=2,
        color=proc_color.get(proc, "gray"),
        label=f"{proc} hold"
    )

    plt.xlabel("PVT Corner", fontsize=12)
    plt.ylabel("Slack (ns)", fontsize=12)
    plt.title(f"Hold Slack vs PVT Corner", fontsize=14, fontweight="bold")
    plt.xticks(rotation=45, ha="right")
    plt.grid(True, linestyle="--", alpha=0.6)
    plt.legend(title="Process")
    plt.tight_layout()
    plt.savefig("plots/Hold_Slack_vs_PVT_Corner.png")