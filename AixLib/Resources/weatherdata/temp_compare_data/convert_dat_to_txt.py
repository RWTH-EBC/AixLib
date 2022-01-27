import pandas as pd
import io


def load_dat(path, year=2012):
    """
    Function to load the data in the .dat files into
    a dataframe.
    Works for data from TRY 2007 and 2012 datasets, for older
    or newer version not to much.

    """
    _sep = '\s+'

    with open(path, "r") as file:
        if year == 2012:
            _start_data = 34
            cols = ['RW', 'HW', 'MM', 'DD', 'HH', 't', 'p', 'WR', 'WG', 'N', 'x', 'RF', 'B', 'D', 'A', 'E', 'IL']
        else:
            _start_data = 38
            cols = ['RG', 'IS', 'MM', 'DD', 'HH', 'N', 'WR', 'WG', 't', 'p', 'x', 'RF', 'W', 'B', 'D', 'IK', 'A', 'E', 'IL']
        lines = file.readlines()
        comment_lines = lines[:_start_data]
        comment_lines_out = []
        for line in comment_lines:
            comment_lines_out.append("#" + line)
        data_lines = lines[_start_data:]

        data_lines.insert(0, " ".join(cols) + "\n")
        output = io.StringIO()
        output.writelines(data_lines)
        output.seek(0)
        df = pd.read_csv(output, sep=_sep, header=0)
        # Convert the hours to seconds
        df.index *= 3600

    return df, comment_lines_out


def convert_dat_to_txt(path, year):
    import pathlib
    path = pathlib.Path(path)
    df, comment_lines = load_dat(path, year)
    # Add comment line and double wetter
    comment_lines.insert(0, "#1\n")
    comment_lines.append(f"double wetter(8761, {len(df.columns)+1})\n")
    # Duplicate last row and insert at first location
    df.index += 3600
    df.loc[0] = df.iloc[-1]
    df = df.sort_index()
    # Write to file
    with open(path.parent.joinpath(path.stem + ".txt"), "w+") as file:
        file.writelines(comment_lines)
        s = io.StringIO()
        df.to_csv(s, sep="\t")
        data = s.getvalue()
        data = data.replace("\r\n", "\n")
        data = data.replace(".0\t", "\t")
        data = data.replace(".0\n", "\n")
        file.write("\n".join(data.split("\n")[1:]))


if __name__ == '__main__':
    convert_dat_to_txt("TRY2010_12_Jahr.dat", 2010)
