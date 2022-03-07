Prioritisation mismatch using dispersal-based connectivity assessment
========================================================================

## Description

This repository contains several R scripts to reclassify and compare connectivity maps (obtained with PinchPoint Mapper) as proposed in [this study](https://www.maximelenormand.com/Publications#mismatchconnectivitypaper). The workflow takes as input a set of rasters (same extend and resolution) that represents the connectivity map of several species. First, the rasters are reclassified in six levels of connectivity using the Loubar method [[1]](https://www.nature.com/articles/srep05276) as described in [[2]](https://www.nature.com/articles/s41467-019-12809-y). We then build for each pair of reclassified rasters a matrix where each element represents the number of shared pixels between the different levels of connectivity. We finally compute a metric of similarity [[2]](https://www.nature.com/articles/s41467-019-12809-y) between connectivity maps, defined as the tri-diagonal trace of the matrix defined above.

## Scripts

**main.R** reclassify the rasters contained in the folder ***Input_rasters***, outputs from PinchPoint Mapper, in six levels of connectivity, where level 0 equals to habitat patches and levels 1, 2, 3, 4 and 5 stand for corridor levels, from high to low connectivity potential (values of 6 and 7 respectively represented areas with no connectivity or outside the calculation area of Pinchpoint mapper). The five corridor levels are determine with the functions **thot()** and **hthot()** contained in **classify.R**. The threshold for defining levels using a non-parametric method based on the derivative of the Lorenz curve [[2]](https://www.nature.com/articles/s41467-019-12809-y). The reclassify rasters are then exported in the folder ***Output_rasters***. We then compute a confusion matrix between each pair of reclassified rasters. This squared matrix contained 7 rows and 7 columns corresponding to the different levels of connectivity 0 (patches), 1 to 5 (corridor levels) and 6 (no connectivity). Each element of the matrix represents the number of pixels in common for different couple of levels between two raster maps. The function **phi()** contained in **phi.R** take as input this confusion matrix to compute the similarity between maps defined as the ratio between the sum of the tri-diagonal trace of a matrix and the sum of the matrix [[2]](https://www.nature.com/articles/s41467-019-12809-y).

## Contributors

- [Maxime Lenormand](https://www.maximelenormand.com/)
- [Clémentine Préau](https://scholar.google.fr/citations?user=Bp6ocmIAAAAJ&hl=fr)

## References

[1] Louail *et al.* (2014) [From mobile phone data to the spatial structure of cities](https://www.nature.com/articles/srep05276). *Scientific reports* 4, 5276.

[2] Bassolas *et al.* (2019) [Hierarchical organization of urban mobility and its connection with city livability](https://www.nature.com/articles/s41467-019-12809-y). *Nature communications* 10, 4817.

[3] Préau *et al.* (2021) [Prioritisation mismatch using dispersal-based connectivity assessment](https://arxiv.org/abs/2105.06702). *arXiv preprint* arXiv:2105.06702.  

## Citation

If you use this code, please cite:

Préau *et al.* (2022) [Prioritisation mismatch using dispersal-based connectivity assessment](https://link.springer.com/article/10.1007/s10980-021-01371-y). *Landscape Ecology* 37, 729-743.  

If you need help, find a bug, want to give me advice or feedback, please contact me!
You can reach me at maxime.lenormand[at]inrae.fr
