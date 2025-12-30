import pandas as pd


def read_config(path):
    config = {}
    with open(path, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if line and "=" in line:
                key, value = line.split("=", 1)
                config[key.strip()] = value.strip()
        return config


def change_userid(df, cols):
    n = len(df)
    seq = pd.RangeIndex(start=1, stop=n + 1)
    df['new_user_id'] = seq
    return df


def main():
    config = read_config("config/change_userid.txt")

    input_csv = config.get("input")
    output_csv = config.get("output")
    cols = [c.strip() for c in config.get("cols", " ").split(",") if c.strip()]

    if not input_csv or not cols:
        raise ValueError("Config file must contain at least 'input' and 'cols'")

    df = pd.read_csv(input_csv)
    df = change_userid(df, cols)
    df.to_csv(output_csv, index=False)
    print("Success")


if __name__ == "__main__":
    main()
