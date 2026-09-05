# 🏞️ **Water Quality Prediction and Contamination Assessment using Machine Learning**

## 📝 **Research Overview**

### ❗️**Problem Statement**

Machine learning has achieved strong results in water quality prediction, with previous studies reporting coefficient of determination (R2) values of approximately 0.74 to 0.99 across different modeling approaches and datasets. These findings demonstrate that data-driven methods can provide accurate predictions when evaluated within their respective study settings.

However, much of the existing evidence is based on models developed and tested using data from a single river system, geographical region, or environmental setting (Abbas et al., 2024; del Castillo et al., 2024; Dodig et al., 2024; Li et al., 2023; Perumal et al., 2023). Because water quality characteristics and environmental conditions differ between regions, strong performance within one study area does not necessarily indicate that the same level of performance will be retained when the model is applied elsewhere.

This creates an important limitation in the current literature. Although many models demonstrate high predictive accuracy in their original study environments, there is comparatively limited evidence showing how well their performance is maintained when evaluated under different regional conditions. Consequently, the extent to which existing water quality prediction models can be applied beyond the environments in which they were developed remains unclear.

Addressing this limitation requires evaluation strategies that incorporate data from more than one geographical region. Accordingly, this research develops and evaluates a machine learning model using water quality data from multiple regional settings to examine both predictive performance and generalizability. The resulting model is further incorporated into an integrated machine learning framework that combines multi-source environmental data with automated inference and contamination assessment capabilities.

### ❓ **Research Questions**

1. What are the limitations of existing approaches for water quality prediction and contamination assessment?
2. How can a machine learning model be developed for water quality prediction across different environmental conditions?
3. How effective is the developed machine learning model for water quality prediction in terms of predictive performance and generalizability across different environmental conditions?

### 🎯 **Research Objectives**

1. To identify the limitations of existing approaches for water quality prediction and contamination assessment.
2. To develop a machine learning model for water quality prediction across different environmental conditions.
3. To evaluate the predictive performance and generalizability of the developed machine learning model for water quality prediction across different environmental conditions.

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
