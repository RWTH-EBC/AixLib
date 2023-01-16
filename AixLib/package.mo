within ;
package AixLib

  annotation (
  uses(
	SDF(version="0.4.2"),
	Modelica_DeviceDrivers(version="2.0.0"),
    Modelica(version="4.0.0")),
  version="1.3.2",
  conversion(from(
    version="0.3.2",
                     script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.3.2_to_0.4.mos",
    version="0.5.0",
                     script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.5.0_to_0.5.1.mos",
    version="0.5.2",
                     script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.5.2_to_0.5.3.mos",
    version="0.5.3",
                     script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.5.3_to_0.5.4.mos",
    version="0.5.4",
                     script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.5.4_to_0.5.5.mos",
    version="0.6.0",
                     script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.6.0_to_0.7.0.mos",
    version="0.7.3",
                     script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.7.3_to_0.7.4.mos",
    version="0.7.4",
                     script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.7.4_to_0.7.5.mos",
    version="0.7.5",
                     script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.7.5_to_0.7.6.mos",
    version="0.7.6",
                     script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.7.6_to_0.7.7.mos",
    version="0.7.7",
                     script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.7.7_to_0.7.8.mos",
    version="0.7.8",
                     script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.7.8_to_0.7.9.mos",
    version="0.7.9",
                     script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.7.9_to_0.7.10.mos",
    version="0.7.10",
                      script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.7.10_to_0.7.11.mos",
    version="0.7.11",
                      script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.7.11_to_0.7.12.mos",
    version="0.7.12",
                      script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.7.12_to_0.8.0.mos",
    version="0.8.0",
                     script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.8.0_to_0.8.1.mos",
    version="0.8.1",
                     script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.8.1_to_0.8.2.mos",
    version="0.8.2",
                     script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.8.2_to_0.8.3.mos",
    version="0.9.1",
                     script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.9.1_to_0.9.2.mos",
    version="0.9.2",
                     script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.9.2_to_0.9.3.mos",
    version="0.9.3",
                     script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.9.3_to_0.9.4.mos",
    version="0.9.4",
                     script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.9.4_to_0.10.0.mos",
    version="0.10.0",
                      script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.10.0_to_0.10.1.mos",
    version="0.10.1",
                      script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.10.1_to_0.10.2.mos",
    version="0.10.2",
                      script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.10.2_to_0.10.3.mos",
    version="0.10.3",
                      script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.10.3_to_0.10.4.mos",
    version="0.10.4",
                      script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.10.4_to_0.10.5.mos",
    version="0.10.5",
                      script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.10.5_to_0.10.6.mos",
    version="0.10.6",
                      script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.10.6_to_0.10.7.mos",
    version="0.10.7",
                      script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.10.7_to_0.11.0.mos",
    version="0.11.0",
                      script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.11.0_to_0.11.1.mos",
    version="0.11.1",
                      script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.11.1_to_0.12.0.mos",
    version="0.12.0",
                      script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.12.0_to_0.12.1.mos",
    version="1.0.1",
                      script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_1.0.1_to_1.0.2.mos",
	version="1.0.2",
                      script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_1.0.2_to_1.0.3.mos",
    version="1.0.3",
                      script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_1.0.3_to_1.1.0.mos",
	version="1.1.0",				  
					  script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_1.1.0_to_1.2.0.mos",
	version="1.2.0",				  
					  script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_1.2.0_to_1.2.1.mos",
	version="1.2.1",				  
					  script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_1.2.1_to_1.2.2.mos",
	version="1.3.0",				  
					  script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_1.3.0_to_1.3.1.mos",
	version="1.3.1",				  
					  script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_1.3.1_to_1.3.2.mos")					  
					  ),
  Documentation(info = "<html><p>
  The free open-source <code>AixLib</code> library is being developed
  for research and teaching purposes. It aims at dynamic simulations of
  thermal and hydraulic systems to develop control strategies for HVAC
  systems and analyse interactions in complex systems. It is used for
  simulations on component, building and city district level. As this
  library is developed mainly for academic purposes, user-friendliness
  and model robustness is not a main task. This research focus thus
  influences the layout and philosophy of the library.
</p>
<p>
  Various connectors of the Modelica Standard Library are used, e.g.
  <code>Modelica.Fluid</code> and <code>Modelica.HeatTransfer</code>.
  These are accompanied by own connectors for simplified hydraulics (no
  <code>fluid.media</code>, incompressible, one phase) , shortwave
  radiation (intensity), longwave radiation (heat flow combined with a
  virtual temperature) and combined longwave radiation and thermal. The
  pressure in the connectors is the total pressure. The used media
  models are simplified from the <code>Modelica.Media</code> library.
  If possible and necessary, components use continuously differentiable
  equations. In general, zero mass flow rate and reverse flow are
  supported.
</p>
<p>
  Most models have been analytically verified. In addition, hydraulic
  components are compared to empirical data such as performance curves.
  High and low order building models have been validated using a
  standard test suite provided by the ANSI/ASHRAE Standard 140 and VDI
  6007 Guideline. The library has only been tested with Dymola.
</p>
<p>
  The web page for this library is <a href=
  \"https://www.github.com/RWTH-EBC/AixLib\">https://www.github.com/RWTH-EBC/AixLib</a>.
  We welcome contributions from different users to further advance this
  library, whether it is through collaborative model development,
  through model use and testing or through requirements definition or
  by providing feedback regarding the model applicability to solve
  specific problems.
</p>
</html>"),
   Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={214,62,54},
          fillPattern=FillPattern.Solid,
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Bitmap(extent={{-74,-80},{78,80}}, fileName="modelica://AixLib/Resources/Images/Icon_Modelica_AixLib.png")}));
end AixLib;
