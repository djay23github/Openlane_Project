import os
import subprocess
import re


def run_sta(lib_dir, tcl_file, temp_file):
    
    # Get all lib files in a list
    lib_files = [f for f in os.listdir(LIB_DIR) if f.endswith(".lib")]

    # Loop through each library
    for lib_file in lib_files:
        # library name
        lib_name = lib_file
        # file directory where the files will be saved
        file_dir = lib_file.split("__")[1].split("_")[0].upper()

        # read the tcl script 
        with open(TCL_FILE, "r") as tclfile:
            tcl_data = tclfile.read()

            # Modifying the lib name and file dir dynamically
            tcl_data = tcl_data.replace(
                'set lib_name', f'set lib_name "{lib_name}"\n # auto-modified'
            )
            tcl_data = tcl_data.replace(
                'set file_dir', f'set file_dir "{file_dir}"\n # auto-modifiled'
            )

        # Write the temp tcl file
        with open(TEMP_FILE, "w") as f:
            f.write(tcl_data)

        print(f"\n Running STA file for {lib_name}")
        try:
            # run the sta command till all lib files are parsed
            subprocess.run(["sta","-exit", TEMP_FILE])
        except subprocess.CalledProcessError as e:
            print(f" Command failed: {e}")


def get_power(report_dir, process):
    power_data = []
    for p in process:
        proc_path = os.path.join(report_dir, p)
        for f in os.listdir(proc_path):
            parts = f.split(".")
            if parts[1] == "power":
                pvt = f.split("__")[1].replace(".lib.rpt", "")
                power_file = os.path.join(proc_path, f)
                with open(power_file, "r") as pf:
                    for line in pf:
                        if line.strip().startswith("Total"):
                            tot_power = line.replace(" " , "_").split("_")[27]
                            power_data.append((p, pvt, tot_power))

    return power_data



def get_timing(report_dir, process):

    results = []
    path_type = None
    path_re = re.compile(r"Path Type\s*:\s*(\w+)", re.IGNORECASE)
    slack_re = re.compile(r"([-\d.]+)\s+slack\s*\((MET|VIOLATED)\)", re.IGNORECASE)
    for p in process:
        proc_path = os.path.join(report_dir, p)
        for f in os.listdir(proc_path):
            parts = f.split(".")
            if parts[1] == "timing":
                pvt = f.split("__")[1].replace(".lib.rpt", "")
                timing_file = os.path.join(proc_path, f)
                with open(timing_file, "r") as tf:
                    for line in tf:
                        stripped = line.strip()
                        path_match = path_re.search(stripped)
                        if path_match:
                            path_type = path_match.group(1)
                            if path_type == "min":
                                path_type = "hold"
                            else:
                                path_type = "setup"
                            continue

                        slack_match = slack_re.search(stripped)
                        if slack_match:
                            value = float(slack_match.group(1))
                            status = slack_match.group(2).upper()
                            results.append((p, pvt, path_type, value, status))

    return results                



if __name__ == "__main__":

    LIB_DIR = "../libs"
    TCL_FILE = "pmu_fsm.tcl"
    TEMP_FILE = "pmu_fsm_temp.tcl"
    REPORT_DIR ="reports/"
    process = ["FF", "SS", "TT"]
    power_output_file = "power_summary.rpt"
    timing_output_file = "timing_summary.rpt"
    
    run_sta(LIB_DIR, TCL_FILE, TEMP_FILE)

    power_data = get_power(REPORT_DIR, process)
    with open(power_output_file, "w") as p_out:
        p_out.write(f"{'Process':<10}{'PVT Corner':<30}{'Total Power'}\n")
        for p, pvt, power in power_data:
            p_out.write(f"{p:<10}{pvt:<30}{power}\n")

    timing_data = get_timing(REPORT_DIR, process)
    with open(timing_output_file, "w") as t_out:
        t_out.write(f"{'Process':<10}{'PVT Corner':<30}{'Path Type':<15}{'Slack':<12}{'Status'}\n")
        for p, pvt, path_type, slack, status in timing_data:
            t_out.write(f"{p:<10}{pvt:<30}{path_type:<15}{slack:<12} {status}\n")                    
                        
    
    
