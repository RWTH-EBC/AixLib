![E.ON EBC RWTH Aachen University](./AixLib/Resources/Images/EBC_Logo.png)
[![OM](https://rwth-ebc.github.io/AixLib/main/om_readiness_badge.svg)](https://libraries.openmodelica.org/branches/master/AixLib/AixLib.html)

# <img src="./AixLib/Resources/Images/Icon_Modelica_AixLib_background.png" width="40"> AixLib

**AixLib** is a Modelica model library for building performance simulations.  
The library contains models of HVAC systems as well as high and reduced order building models.  
It is being developed at [RWTH Aachen University, E.ON Energy Research Center, Institute for Energy Efficient Buildings and Indoor Climate (EBC)](https://www.ebc.eonerc.rwth-aachen.de/) in Aachen, Germany.

As the library is developed at RWTH Aachen University's EBC, the library's name **AixLib** is derived from the city's French name Aix-la-Chapelle, which the people of Aachen are very fond of and use a lot. With the name **AixLib** we follow this local tradition.

If you have any questions regarding **AixLib**, feel free to contact us at aixlib@eonerc.rwth-aachen.de.

## Clone repository

* To clone the repository for the first time run:  
  ``git clone --recurse-submodules https://github.com/RWTH-EBC/AixLib.git``
* If you have already cloned the repository, run:  
  ``git submodule update --init --recursive``
* The default branch of AixLib is the ``main`` branch. This means that after cloning the repository, you always checked out the ``main`` branch.

## Release versions

The latest version is always available on the [release page](https://github.com/RWTH-EBC/AixLib/releases) and defined in [AixLib's package.mo](https://github.com/RWTH-EBC/AixLib/blob/master/AixLib/package.mo).

## How to cite AixLib

We continuously improve **AixLib** and try to keep the community up-to-date with citable papers.
Please use the following article for citations when using or enhancing AixLib.

```bibtex
@article{doi:10.1080/19401493.2023.2250521,
  author = {Laura Maier and David Jansen and Fabian Wüllhorst and Martin Kremer and Alexander Kümpel and Tobias Blacha and Dirk Müller},
  title = {AixLib: an open-source Modelica library for compound building energy systems from component to district level with automated quality management},
  journal = {Journal of Building Performance Simulation},
  volume = {17},
  number = {2},
  pages = {196-219},
  year  = {2023},
  publisher = {Taylor & Francis},
  doi = {10.1080/19401493.2023.2250521},
  URL = {https://doi.org/10.1080/19401493.2023.2250521 },
  eprint = {https://doi.org/10.1080/19401493.2023.2250521 }
}
```

## Publications using AixLib

Please see the [publications list](https://github.com/RWTH-EBC/AixLib/blob/master/PUBLICATIONS.md)

## How to contribute to the development of AixLib

You are invited to contribute to the development of **AixLib**.
Issues can be reported using this site's [Issues section](https://github.com/RWTH-EBC/AixLib/issues).
Furthermore, you are welcome to contribute via [Pull Requests](https://github.com/RWTH-EBC/AixLib/pulls). The workflow for changes is described in our [Wiki](https://github.com/RWTH-EBC/AixLib/wiki).

## License

The **AixLib** Library is released by RWTH Aachen University, E.ON Energy Research Center, Institute for Energy Efficient Buildings and Indoor Climate and is available under a 3-clause BSD-license.
See [AixLib Library license](https://htmlpreview.github.io/?https://github.com/rwth-ebc/aixlib/blob/main/AixLib/UsersGuide/License.mo).

## Acknowledgements

Parts of **AixLib** have been developed within public funded projects and with financial support by BMWi (German Federal Ministry for Economic Affairs and Energy).
