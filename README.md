# Cam Profile Analysis using Polynomial Segments

This MATLAB script computes and visualizes the **displacement**, **velocity**, **acceleration**, and **jerk** of a cam follower system based on a segmented polynomial motion profile. It uses symbolic math to evaluate piecewise motion functions and outputs high-resolution plots for each kinematic parameter.

## 📌 Features

- Symbolic modeling of cam motion using equations 8-15 through 8-19 (custom polynomial segments)
- Handles multiple lift segments with variable angles and heights
- Generates high-resolution plots for:
  - Displacement
  - Velocity
  - Acceleration
  - Jerk
- Exports each plot to PNG format with customizable resolution

## 🧠 Background

This analysis is based on cam motion design as found in mechanical systems. It implements polynomial motion laws to smoothly transition the cam follower through various segments, allowing for accurate modeling of complex cam profiles.

## 📂 Files Generated

- `s_plot.png`: Displacement vs. Cam Rotation Angle
- `v_plot.png`: Velocity vs. Cam Rotation Angle
- `a_plot.png`: Acceleration vs. Cam Rotation Angle
- `j_plot.png`: Jerk vs. Cam Rotation Angle

## 🛠️ How to Run

1. Open MATLAB.
2. Copy the script into a new `.m` file (e.g., `cam_profile_analysis.m`).
3. Run the script. It will automatically:
   - Compute all profiles
   - Display the figures
   - Save high-resolution plots in the current directory

## 📈 Input Parameters

These can be adjusted in the script:

| Variable | Description                       |
|----------|-----------------------------------|
| `C_v`    | Velocity coefficient              |
| `C_a`    | Acceleration coefficient          |
| `C_j`    | Jerk coefficient                  |
| `b, c, d`| Zone length coefficients          |
| `Beta`   | Array of cam segment angles (°)   |
| `h`      | Array of follower lifts (in)      |
| `total_time` | Total cam rotation time (s)   |
| `n`      | Resolution (points per segment)   |
| `image_res` | Exported image resolution (dpi)|

## 📦 Dependencies

- MATLAB (R2020 or newer recommended)
- Symbolic Math Toolbox
- No additional toolboxes are required beyond built-in plotting

## 📸 Example Output

Sample displacement plot:

![Displacement](s_plot.png)

## ✍️ Author

Created by Spencer Kenison  
Mechanical Engineering | Utah State University

---

