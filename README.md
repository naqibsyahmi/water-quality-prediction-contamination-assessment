# 🏞️ **Water Quality Prediction and Contamination Assessment using Machine Learning**

## 📝 **Research Overview**

### ❗️**Problem Statement**

Existing water quality prediction studies have demonstrated strong predictive performance, with reported coefficient of determination (R2) values ranging between approximately 0.74 and 0.99 across different machine learning techniques and water quality datasets. These findings indicate the potential of machine learning approaches to support accurate water quality prediction and contamination assessment.

Despite these promising results, many existing studies develop and evaluate their models using datasets collected from a single water system, geographical region or environmental setting (Abbas et al., 2024; del Castillo et al., 2024; Dodig et al., 2024; Li et al., 2023; Perumal et al., 2023). Since environmental characteristics and water quality conditions may vary across geographical regions, it remains uncertain whether the predictive performance achieved within one environmental setting can be maintained when the model is applied to different environmental conditions.

Consequently, although high predictive performance is often achieved within individual study areas, limited evidence is available regarding whether these models can maintain similar predictive performance when applied across different environmental conditions. As a result, the broader applicability of existing water quality prediction models beyond their original study areas remains uncertain.

Therefore, there is a need to evaluate water quality prediction models using datasets from multiple geographical regions to better understand and improve their generalizability across different environmental conditions. To address this research gap, this research aims to develop and evaluate a machine learning model using datasets collected from multiple geographical regions to assess its predictive performance and generalizability across different environmental conditions. The developed model is subsequently integrated into an integrated machine learning framework that supports water quality prediction and contamination assessment through the integration of machine learning techniques, multi-source water quality data, and real-time inference capabilities.

### ❓ **Research Questions**

1. What are the limitations of existing approaches for water quality prediction and contamination assessment?
2. How can machine learning techniques improve the generalizability of water quality prediction across different environmental conditions?
3. How effective is the developed machine learning model for water quality prediction across different environmental conditions?

### 🎯 **Research Objectives**

1. To identify the limitations of existing approaches for water quality prediction and contamination assessment.
2. To develop a machine learning model for water quality prediction with improved generalizability across different environmental conditions.
3. To evaluate the predictive performance and generalizability of the developed machine learning model across different environmental conditions.

## 🚀 **Getting Started**

### **Preliminaries**

1.  **Python 3.10++**: Please ensure that Python 3.10 or higher is installed on your system before running this project. You can download the required version from the official website [Install Python](https://www.python.org/downloads/).

### **Setting Up the Environment**

1. Clone the repository by running the following command in your terminal:
    ```
    https://github.com/naqibsyahmi/river-water-quality-prediction-contamination-assessment.git
    ```

2. Create a virtual environment named **`venv`** in your project folder by running the following command:

    - **On Windows:**
    ```
    python -m venv venv
    ```

    - **On macOS/Linux:**
    ```
    python3 -m venv venv
    ```

3. Activate the virtual environment based on your operating system:

    - **On Windows:**
    ```
    venv\Scripts\activate
    ```

    - **On macOS/Linux:**
    ```
    source venv/bin/activate
    ```

4. Once the virtual environment is successfully created and activated, run the following command in your terminal to install the required packages:

    - **On Windows:**
    ```
    pip install -r requirements.txt
    ```

    - **On macOS/Linux:**
    ```
    pip3 install -r requirements.txt
    ```

### **Running the Notebook and System**
