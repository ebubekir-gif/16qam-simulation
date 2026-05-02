# 16-QAM Simulation and BER Performance Analysis

A complete, vector-optimized MATLAB simulation of a 16-Quadrature Amplitude Modulation (16-QAM) system built entirely from scratch. 

This project demonstrates the core principles of digital communications without relying on MATLAB's built-in Communications Toolbox functions (such as `qammod`, `qamdemod`, or `awgn`). By implementing modulation, noise addition, and demodulation using pure matrix operations and mathematical modeling, this repository highlights a deep understanding of algorithm design and telecommunication theory.

## 🚀 Key Features

* **Zero Toolbox Dependency:** Built using core MATLAB functions only.
* **Vectorized Demodulation:** Replaces slow Euclidean distance `for` loops with geometric decision boundaries (thresholding), reducing execution time by over 90%.
* **Gray Mapping:** Implemented to ensure adjacent symbols differ by only one bit, minimizing the overall Bit Error Rate (BER).
* **Custom AWGN Channel:** Mathematically accurate calculation of noise variance based on specific $E_b/N_0$ (SNR) levels.

## 📁 Project Structure

* `main.m` : The primary script that runs the Monte Carlo simulation and generates the plots.
* `functions/`
  * `qam16_modulator.m` : Maps binary data to complex 16-QAM symbols using a custom Look-Up Table (LUT).
  * `add_awgn_noise.m` : Calculates the noise power spectral density ($N_0$) and injects Additive White Gaussian Noise (AWGN) into the signal.
  * `qam16_demodulator.m` : A highly optimized, threshold-based vector demodulator.

## ⚙️ Mathematical Background

### 1. Signal Power & Noise Variance
The noise variance $N_0$ for a given Signal-to-Noise Ratio (SNR) in dB is calculated as:
$$SNR_{linear} = 10^{\frac{SNR_{dB}}{10}}$$
$$N_0 = \frac{P_s}{SNR_{linear} \cdot k}$$
Where $P_s$ is the average signal power and $k = 4$ is the number of bits per symbol for 16-QAM.

### 2. Threshold Demodulation
Instead of calculating the Euclidean distance $d_m = |r - s_m|$ for every received symbol $r$ against all 16 ideal symbols $s_m$, the algorithm uses static boundaries on the Real (In-Phase) and Imaginary (Quadrature) axes. For example, on the I-axis, decisions are made purely by checking if the value is $\geq 0$ and if its absolute value is $< 2$.

## 🛠️ How to Run

1. Clone this repository to your local machine:
   ```bash
   git clone [https://github.com/ebubekir-gif/16qam-simulation.git](https://github.com/ebubekir-gif/16qam-simulation.git)
