within AixLib.Fluid.Movers.Compressors.BaseClasses;
partial model PartialEfficiency
  "Base model that is used to define all further efficiencies"

  // Definition of the medium used for calculations
  //
  replaceable package Medium =
    Modelica.Media.R134a.R134a_ph
    constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium
    "Medium of the model";

  // Definition of inputs
  //
  input Modelica.SIunits.Efficiency epsRef(min=0, max=1, nominal=0.05)
    "Ratio of the real and the ideal displacement volume";
  input Modelica.SIunits.Volume VDis(min=0)
    "Displacement volume";
  input Real piPre(min=0, unit="1")
    "Ratio of compressor's outlet and inlet pressure";
  input Modelica.SIunits.Frequency rotSpe(min=0)
    "Compressor's current rotational speed";
  input Medium.ThermodynamicState staInl
    "Thermodynamic state at compressor's inlet";
  input Medium.ThermodynamicState staOut
    "Thermodynamic state at compressor's outlet";
  input Modelica.SIunits.Temperature TAmb
    "Ambient temperature";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false),
              graphics={
                Ellipse(
                  extent={{-90,-90},{90,90}},
                  lineThickness=0.25,
                  pattern=LinePattern.None,
                  lineColor={215,215,215},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{-40,60},{-30,70},{-20,60},{-20,60}},
                  color={0,0,0},
                  smooth=Smooth.Bezier,
                  thickness=0.5),
                Line(
                  points={{-20,60},{-20,-30},{-20,38},{-16,50},
                          {-6,58},{0,60},{6,58}},
                  color={0,0,0},
                  smooth=Smooth.Bezier,
                  thickness=0.5),
                Line(
                  points={{6,58},{16,50},{20,40},{20,-70},
                          {20,-70},{20,-70},{20,-70}},
                  color={0,0,0},
                  smooth=Smooth.Bezier,
                  thickness=0.5)}),
              Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>October 20, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This is a base model for efficiency models that are required for
  various compressor models. It defines some basic inputs that are
  commonly used by efficiency models presented in <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.Utilities.EngineEfficiency\">
  AixLib.Fluid.Movers.Compressors.Utilities.EngineEfficiency</a>,
  <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency\">
  AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency</a>
  and <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency\">
  AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency</a>.
  These inputs are summarised below:<br/>
</p>
<table summary=\"Inputs and outputs\" border=\"1\" cellspacing=\"0\"
cellpadding=\"2\" style=\"border-collapse:collapse;\">
  <tr>
    <th>
      Type
    </th>
    <th>
      Name
    </th>
    <th>
      Comment
    </th>
  </tr>
  <tr>
    <td>
      <b>input</b>
    </td>
    <td>
      <code>epsRef</code>
    </td>
    <td>
      Ratio of the real and the ideal displacement volume
    </td>
  </tr>
  <tr>
    <td>
      <b>input</b>
    </td>
    <td>
      <code>VDis</code>
    </td>
    <td>
      Displacement volume
    </td>
  </tr>
  <tr>
    <td>
      <b>input</b>
    </td>
    <td>
      <code>piPre</code>
    </td>
    <td>
      Pressure ratio
    </td>
  </tr>
  <tr>
    <td>
      <b>input</b>
    </td>
    <td>
      <code>rotSpe</code>
    </td>
    <td>
      Rotational speed
    </td>
  </tr>
  <tr>
    <td>
      <b>input</b>
    </td>
    <td>
      <code>staInl</code>
    </td>
    <td>
      Thermodynamic state at compressor's inlet conditions
    </td>
  </tr>
  <tr>
    <td>
      <b>input</b>
    </td>
    <td>
      <code>staOut</code>
    </td>
    <td>
      Thermodynamic state at compressor's out conditions
    </td>
  </tr>
  <tr>
    <td>
      <b>input</b>
    </td>
    <td>
      <code>TAmb</code>
    </td>
    <td>
      Ambient temperature
    </td>
  </tr>
</table>
</html>"));
end PartialEfficiency;
