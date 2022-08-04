within AixLib.Fluid.DistrictHeatingCooling;
model UsersGuide "Users' Guide for the District Heating and Cooling package"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html><p>
  This package collects models for District Heating and Cooling
  systems.
</p>
<p>
  The underlying assumption of this package is to built DHC system
  models from modular components. The main components are Demands,
  Pipes, and Supplies. The Base Classes in this package provide
  interfaces for these components, which wrap around different
  implementations of the component models. These can then be assembled
  to system models according to the Users' needs. These can range from
  models only representing the supply network without return lines to
  closed loop system representations, and from static to dynamic
  modeling approaches.
</p>
<p>
  Another key aspect of this package is that the models are build to be
  suited for automated model generation. This may sometimes require
  compromises regarding usability for manual system model assembly, but
  the aim is to keep such cases to a minimum.
</p>
</html>"));
end UsersGuide;
