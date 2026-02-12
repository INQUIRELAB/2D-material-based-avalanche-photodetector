##2D-Material-Based Avalanche Photodetector 

## Authors
- Tonmoy Malakar  
- Yaser Banad  
- Sarah S. Sharif* (Corresponding Author)

## Abstract
Uncooled mid-infrared avalanche photodetectors remain challenging because the high electric fields required for impact ionization can induce leakage and contact-related noise in narrow-bandgap semiconductors. This repository provides analysis scripts and datasets supporting a van der Waals black phosphorus/multilayer graphene (BP/MLG) avalanche photodiode based on a field-engineered vertical **p⁺–i–p–n⁺** heterostructure that sustains a strong depletion field for controlled avalanche multiplication. Simulations predict room-temperature operation across **3–8 µm**, with avalanche onset near **Vrb ≈ 11 V**, gain increasing to **M ≈ 8.1** at 21 V, and peak responsivity near **λ ≈ 3.4 µm**.

## Repository Contents
This repository is organized as a set of MATLAB analysis scripts (`.m`) and supporting datasets (`.xlsx`):

### MATLAB Scripts
- `Photocurrent.m` — photocurrent analysis workflow.
- `Responsivity.m` — responsivity extraction and plotting.
- `EQE vs Responsivity.m` — EQE–responsivity relationship analysis.
- `Incident power vs Responsivity.m` — responsivity vs incident power analysis.
- `Dark current vs Reverse bias.m` — dark current vs reverse bias analysis.
- `Detectivity vs Noise current.m` — detectivity vs noise current analysis.
- `Fabrication Torelence 1 and 2.m` — layer-thickness tolerance study (case 1–2).
- `Fabrication Torelence 3 and 4.m` — layer-thickness tolerance study (case 3–4).

### Data Files (Excel)
- `Current under illumination.xlsx` — illumination-dependent current data.
- `Darkcurrent.xlsx` — dark current dataset.
- `EQE.xlsx` — external quantum efficiency dataset.

### License
- `LICENSE` — **MIT License**

## How to Use
1. Open MATLAB (R2018a or newer recommended).
2. Place the `.m` scripts and `.xlsx` files in the same folder (this repository root).
3. Run the scripts as needed; each script is intended to load the corresponding Excel dataset and generate plots/metrics.

> Tip: If MATLAB cannot find an Excel file, ensure your current working directory is set to the repository root.

## Notes on Naming
Some filenames intentionally match the manuscript’s plot labels. If you prefer cleaner names, consider renaming files and updating the corresponding `readtable` / `xlsread` paths inside the scripts.

## License
This project is released under the **MIT License**.
"""

out_path = Path("/mnt/data/README_updated.md")
out_path.write_text(readme, encoding="utf-8")
out_path.as_posix()

