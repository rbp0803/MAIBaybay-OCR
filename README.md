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
* /Algorithms folder contains the source code for implementing MAIBaybay. Due to the 25 MB maximum file size restriction, some files such as the Baybayin character SVM classifier, NLP baseline models, and the Filipino text corpus are provided in the Release Section: [https://github.com/rbp0803/MAIBaybay-OCR/releases/tag/v1.0.](https://github.com/rbp0803/MAIBaybay-OCR/releases/tag/v1.0)
  * _Note 1_: Ensure that all classifiers are in the same folder. Once the source code is compiled, run the `MAIBaybayOCR_App.mlapp` to access the MAIBaybay software
  * _Note 2_: The system defaults to utilize the OpenAI API for the LLM integration. It requires access to the internet and a valid OpenAI API key.
  * _Note 3_: Load the OpenAI API key first before testing any sample images to avoid system error.
  * _Note 4_: The `FilNLPProcess.m` file contains the function that calls the LLM model. Users may choose to change the LLM model through this function. By default, the model is set to "gpt-5" (standard model).
  * _Note 5_: The /Baseline Methods subfolder contains functions used to implement the baseline NLP methods instead of the LLM-based method.
    * This is achieve by integrating `contextfinder_baselinemethod.m` and its subfunctions into the source code.
    * It also requires commenting out line 190 in `Baybayintransliterations.m` and activating line 191.  
 
* /Datasets folder contains datasets to assess the performance of the MAIBaybay system.
  * The /(Ambiguous) Baybayin Text Images subfolder contains 100 data images featuring Baybayin (and Baybayin-Latin) texts, each with at least one ambiguous Baybayin word. A list of gold-standard transliterations for each image phrase is also included.
  * The /Filipino Text Corpus subfolder holds an instruction on how to access the utilized Tagalog text corpus.
  * The file `Tagalog Minimal-Pair List.xlsx` provides a list of more than 40 Tagalog minimal pairs that correspond to ambiguous Baybayin word.
    * _Note_: The collected words include only pairs identified by the authors as having identical Baybayin forms during the conduct of this project. The list may be expanded in the future, as some minimal pairs may not have been included, and the Filipino language is dynamic and continues to evolve over time.

## References

We refer the readers to the following references for the MAIBaybay's backbone algorithms:
 1. Pino R, Mendoza R, Sambayan R. 2021. Optical character recognition system for Baybayin scripts using support vector machine. PeerJ Comput. Sci. 7:e360 http://doi.org/10.7717/peerj-cs.360
 2. Pino R, Mendoza R, Sambayan R. 2021. A Baybayin word recognition system. PeerJ Comput. Sci. 7:e596 http://doi.org/10.7717/peerj-cs.596 
 3. Pino R, Mendoza R, Sambayan R. 2022. Block-level optical character recognition system for automatic transliterations of baybayin texts using support vector machine. Philipp. J. Sci. 151 (1), 303-315, https://doi.org/10.56899/151.01.23.
 4. Pino, R., Mendoza, R., & Sambayan, R. (2025). MaBaybay-OCR: A MATLAB-based Baybayin optical character recognition package. SoftwareX, 29, 102003. https://doi.org/10.1016/j.softx.2024.102003

## Queries

For inquiries regarding the source code and data, please email me at rbpino@up.edu.ph.
