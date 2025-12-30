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


def split_date_time(df: pd.DataFrame, cols):
    for col in cols:
        ts = pd.to_datetime(df[col], errors="coerce")
        df[f"date"] = ts.dt.strftime("%Y-%m-%d")
        df[f"time"] = ts.dt.strftime("%H:%M:%S")

        # Date parts
        df[f"day"] = ts.dt.day.astype("Int64")
        df[f"month"] = ts.dt.month.astype("Int64")
        df[f"quarter"] = ts.dt.quarter.astype("Int64")
        df[f"year"] = ts.dt.year.astype("Int64")

        # Time parts
        df[f"hour"] = ts.dt.hour.astype("Int64")
        df[f"minute"] = ts.dt.minute.astype("Int64")
        df[f"second"] = ts.dt.second.astype("Int64")

    return df


def main():
    config = read_config("config\split_date_time.txt")

    input_csv = config.get("input")
    output_csv = config.get("output")
    cols = [c.strip() for c in config.get("cols", "").split(",") if c.strip()]

    if not input_csv or not cols:
        raise ValueError("Config file must contain at least 'input' and 'cols'")

    df = pd.read_csv(input_csv)
    df = split_date_time(df, cols)
    df.to_csv(output_csv, index=False)

    print(
        f"Saved → {output_csv} with new columns: "
        + ", ".join([f"{c}_date, {c}_time" for c in cols])
    )


if __name__ == "__main__":
    main()
