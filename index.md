---
layout: page
title: FLIMfit
---

FLIMfit is a software tool and an OMERO client that is designed to facilitate analysis and visualisation of time-resolved data from FLIM (Fluorescence Lifetime Imaging) measurements including time-correlated single photon counting (TCSPC) and wide-field time-gated imaging. It can incorporate image segmentation and utilises a highly efficient algorithm that can globally fit FLIM data with modest photon numbers to complex decay models, across hundreds of fields of view, requiring only tens of seconds of processing time on a reasonable desktop computer. This makes it useful to analyse time series or multiwell plate FLIM data. Please see [Warren et al, 2013](http://www.plosone.org/article/info%3Adoi%2F10.1371%2Fjournal.pone.0070687) for further details.

[Download FLIMfit for Windows or Mac]({{site.links.downloads}})

![placeholder]({{site.baseurl}}images/screenshot.png)

Importing FLIM data
-------------------
Users can import raw FLIM data using OMERO, fit it to a fluorescence decay model using the FLIMfit OMERO client and then save the resultant images to an OMERO.server or to disk. FLIM data can also be imported directly from disk. FLIMfit now supports OME-TIFF and most types of FLIM files using the Bio-Formats library. FLIM data previously imported to an OMERO.server is also supported, as described in Supported File Formats.

Fitting FLIM data
-----------------
FLIMfit is able to fit lifetime data to monoexponential decay profiles or to complex decay profiles with multiple exponential decay components. It incorporates image segmentation (e.g. to define regions of interest) and can be used in conjunction with [CellProfiler](http://www.cellprofiler.org/).

FLIM data can be analysed on a pixelwise basis or utilising global binning (where all the pixels in a region of interest are combined to create a “single pixel” with more photons). FLIMfit can also provide global fitting (where the lifetime components are assumed to be spatially invariant across images or regions of interest and are fitted simultaneously by minimising a global χ² ). For global fitting the model parameters can be linked if required (e.g. to analyse FRET data with complex donor decay profiles).

Global fitting can be applied across an arbitrary number of images or regions of interest, including across time series and/or arrays of fluorescence lifetime images. FLIMfit can also be applied to time-resolved fluorescence anisotropy data and in general to complex models for multichannel FLIM data.

Visualising FLIM data
---------------------
The fitting client enables users to generate false-colour maps of their selected model parameters, to adjust the range over which the colour map is applied for each parameter, and to produce a 'merged' image where the intensity of the false-colour, at each pixel, is modulated by the relative brightness of the original data. This allows particular features to be visually highlighted and structural, as well as lifetime, information to be represented in a single image. The software also provides for the convenient display of histograms of each fitted parameter, as well as correlation and error bar plots. All these images can be saved into OMERO, enabling sharing and collaboration.

Acknowledging FLIMfit
---------------------
This software was primarily developed by Sean Warren within the [Photonics Group](http://www.openmicroscopy.org/site/about/development-teams/paul) of the Physics Department at Imperial College London as part of his PhD project, which was supported by the UK Engineering and Physical Sciences Council through a studentship from the Institute of Chemical Biology. This was undertaken with colleagues from the Photonics Group (Yuriy Alexandrov, Dominic Alibhai, Christopher Dunsby, Paul French, Douglas Kelly, Sunil Kumar, Romain Laine, Ian Munro, Clifford Talbot) and its integration with OMERO was supported through a Wellcome Trust grant entitled "The Open Microscopy Environment: Image Informatics for Biological Sciences" (Ref: 095931) in collaboration with colleagues from the University of Dundee.

Please explicitly acknowledge "the FLIMfit software tool developed at Imperial College London" in any publications benefitting from its use. In order for us to monitor the use of FLIMfit and to support its ongoing development, we would be grateful if you could send details of any such publications (particularly DOIs of published papers) to: FLIMfit@imperial.ac.uk.

Licensing and citing information is on the [OME licensing page](http://www.openmicroscopy.org/site/about/licensing-attribution).

User support
------------
There is a mailing list for FLIMfit users which you can [subscribe to, or search the archives of, here](http://lists.openmicroscopy.org.uk/mailman/listinfo/flimfit-users).
