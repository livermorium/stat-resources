import pandas as pd
import matplotlib.pyplot as plt


def draw_top(data_filename, time_filename):
    """
    
    RETURN: 时间戳+真实内存占用+真实内存占用百分比+CPU占用百分比
    """
    top_data = pd.read_csv(data_filename, delim_whitespace=True)
    top_time = pd.read_csv(time_filename)

    mem_percent = top_data["%MEM"]
    cpu_percent =  top_data["%CPU"]

    res = top_data["RES"]

    start_timestamp = top_time["timestamp"][0]
    timestamp =  top_time["timestamp"] - start_timestamp

    return timestamp, res, mem_percent, cpu_percent

def plot(timestamp, res, mem_percent, cpu_percent):
    """
    plot RES+%MEM+%CPU
    """
    fig = plt.figure()

    ax1 = fig.add_subplot(311)
    ax1.set_title("RESOURCES")
    ax1.plot(timestamp, res, "g-", label="RES")
    ax1.grid(True)
    ax1.legend() 

    ax2 = fig.add_subplot(312)
    ax2.plot(timestamp, mem_percent,"b-", label="%MEM")
    ax2.grid(True)
    ax2.legend() 

    ax3 = fig.add_subplot(313)
    ax3.plot(timestamp, cpu_percent,"r-", label="%CPU")
    ax3.grid(True)
    ax3.legend() 

    plt.show()


if __name__ == "__main__":
    import sys
    if len(sys.argv) == 1:
        print("usage: {} <pid>".format(sys.argv[0]))
        sys.exit(-1)
    
    pid = sys.argv[1]

    plot(*draw_top("top.{}.data".format(pid), 
        "time.top.{}.data".format(pid)))
