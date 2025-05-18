import os
import matplotlib.pyplot as plt

def twos_complement_to_int(binary_str):
    """
    Convert a binary string in two's complement format to a signed integer.
    Assumes that the binary_str is complete (i.e., if it's an 8-bit number,
    the string has exactly 8 characters).
    """
    n = len(binary_str)
    value = int(binary_str, 2)
    if binary_str[0] == '1':  # Negative number in two's complement.
        value -= (1 << n)
    return value

def read_and_convert(file_path):
    """
    Reads a text file where each non-empty line contains a binary number.
    Converts each binary number using two's complement for signed numbers.
    """
    decimals = []
    try:
        with open(file_path, 'r') as file:
            for line_number, line in enumerate(file, 1):
                clean_line = line.strip()
                if clean_line:  # Skip empty lines.
                    try:
                        # Convert binary string to integer considering sign.
                        decimal_value = twos_complement_to_int(clean_line)
                        decimals.append(decimal_value)
                    except ValueError:
                        print(f"Warning: Line {line_number} ('{clean_line}') is not a valid binary number. Skipping.")
    except FileNotFoundError:
        print(f"Error: The file '{file_path}' does not exist.")
    return decimals

def plot_time_series(decimals):
    """
    Plots a time series of decimal values.
    The x-axis represents the sample index (i.e., the order the values were read).
    """
    if not decimals:
        print("No valid decimal data to plot.")
        return
    
    time = list(range(len(decimals)))  # Time steps: 0, 1, 2, ... etc.
    
    plt.figure(figsize=(10, 5))
    plt.plot(time, decimals, marker='o', linestyle='-', color='b')
    plt.xlabel("Número de muestra")
    plt.ylabel("Valor Decimal de la muestra")
    plt.title("Muestras en valor decimal")
    plt.grid(True)
    plt.tight_layout()
    plt.show()

def main():
    # Get the directory where the current script is located.
    script_dir = os.path.dirname(os.path.abspath(__file__))
    
    # Build an absolute path to the target file.
    file_path = os.path.join(script_dir, "PA2", "PA2.sim", "sim_1", "behav", "xsim", "f_out.txt")
    
    decimals = read_and_convert(file_path)
    plot_time_series(decimals)

if __name__ == "__main__":
    main()
