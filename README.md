# MAIBaybay-OCR: A Matlab-based AI-assisted Baybayin Optical Character Recognition Software

An LLM-integrated Baybayin OCR software for contextually coherent transliteration of ambiguous Baybayin words.<br>
<sub> _Note: Ambiguous Baybayin words refer to words that have multiple possible equivalents in the modern Filipino alphabet when transliterated._</sub>

## Operating Environments and Dependencies
**System:**
* Windows 10, Windows 11, and later

**Software:**
* MATLAB versions R2025a or later
* Statistics and Machine Learning Toolbox
* Image Processing Toolbox
* Computer Vision Toolbox
* OCR Language Data Files (English and Tagalog)
* Parallel Computing Toolbox

## Usage
* /Algorithms folder contains the source code for implementing MAIBaybay. Due to the 25 MB maximum file size limit, the remaining file Baybayin character SVM classifier is available in the complete package in the in the Releases Section: [https://github.com/rbp0803/MAIBaybay-OCR/releases/tag/v1.0.1](https://github.com/rbp0803/MAIBaybay-OCR/releases/tag/v1.0.1)
  * _Note 1_: Ensure that all classifiers and related files are in the same folder. Once the source code is compiled, open and run the `MAIBaybayOCR_App.mlapp` to access the MAIBaybay software.
  * _Note 2_: The `contextfinder.m` contains the call functions to implement the NLP module. You can select which NLP model to integrate for the post-recognition disambiguation task.  
  * _Note 3_: The system defaults to utilize the (proprietary) OpenAI API for the LLM integration. It requires access to the internet and a valid OpenAI API key.
    * Load the OpenAI API key first before testing any sample images to avoid system error.
    * The `FilNLPProcess_GPTModels.m` file contains the function that calls the LLM model. Users may choose to change the LLM model through this function. By default, the model is set to "**gpt-5**" (standard model).
  * _Note 4_: Alternatively integrate open-source models into the NLP module using still the `contextfinder.m` file. Use `FilNLPProcess_BERTModels.m` for BERT models or `FilNLPProcess_OSLLMs_throughOllama.m` for open-source LLMs. 
    * **BERT Models**: Requires configuring the MATLAB-Python interface and installing Python `transformers` dependencies.
    * **Open-Source LLMs**: Requires installing Ollama and downloading your preferred language model by running `!ollama pull [modelName]` in the MATLAB Command Window.    
 
* /Datasets folder contains the following datasets to assess and support the performance of the MAIBaybay system.
  * The /(Ambiguous) Baybayin Text Images subfolder contains 120 data images featuring Baybayin (and Baybayin-Latin) texts, evenly divided into four sets of 30 Tagalog phrases. Each phrase contains between one and four ambiguous Baybayin words.
  * The file `Ambiguous Baybayin Words List.pdf` provides a list of 41 ambiguous Baybayin words along with their multiple Latin equivalents, their English translations, and their specific contrast types.
    * _Note_: The collected words include only pairs identified by the authors as having identical Baybayin forms during the conduct of this project. The list may be expanded in the future, as some minimal pairs may not have been included, and the Filipino language is dynamic and continues to evolve over time.
  * The ground-truth transliterations for each image phrase are provided in `Ground-Truth Transliteration Labels.pdf`. This file details the phrase length, the ambiguous Baybayin words used, and the total number of phrases generated in each respective image.
    * _Note_: The actual list of candidate phrases per entry can be viewed in any of the model results archive files.
  * `Krippendorff's Coincidence Matrix - Inter-Annotator Agreement.xlsx` provides the coincidence matrix and calculations for Krippendorff's alpha (α) to measure the inter-annotator agreement. 
   
* /Results folder contains the archived results for each model, showing the selected most coherent phrase per data to ensure the reproducibility and transparency of the model evaluations.
  * `BERT Model Results Archive.xlsx` contains the results for the BERT models, with each model's data organized into its respective sheet.
  * `Open-source Instruction Tuned LLM Results Archive.xlsx` contains the results for open-source LLMs across up to 10 runs. Each specific model's results are shown in its respective sheet.
  * `Proprietary Models Results Archive.xlsx` contains the results for proprietary LLMs across up to 10 runs. Each specific model's results are shown in its respective sheet.

## References

We refer the readers to the following references for the MAIBaybay's backbone algorithms:
 1. Pino R, Mendoza R, Sambayan R. 2021. Optical character recognition system for Baybayin scripts using support vector machine. PeerJ Comput. Sci. 7:e360 http://doi.org/10.7717/peerj-cs.360
 2. Pino R, Mendoza R, Sambayan R. 2021. A Baybayin word recognition system. PeerJ Comput. Sci. 7:e596 http://doi.org/10.7717/peerj-cs.596 
 3. Pino R, Mendoza R, Sambayan R. 2022. Block-level optical character recognition system for automatic transliterations of baybayin texts using support vector machine. Philipp. J. Sci. 151 (1), 303-315, https://doi.org/10.56899/151.01.23.
 4. Pino, R., Mendoza, R., & Sambayan, R. (2025). MaBaybay-OCR: A MATLAB-based Baybayin optical character recognition package. SoftwareX, 29, 102003. https://doi.org/10.1016/j.softx.2024.102003

## Queries

For inquiries regarding the source code and data, please email me at rbpino@up.edu.ph.
