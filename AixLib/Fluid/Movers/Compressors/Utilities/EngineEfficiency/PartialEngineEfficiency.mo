within AixLib.Fluid.Movers.Compressors.Utilities.EngineEfficiency;
partial model PartialEngineEfficiency
  "Based model used by all models describing engine efficiencies"
  extends BaseClasses.PartialEfficiency;

  // Definition of parameters
  //
  parameter Boolean useIseWor = false
    "= true, if isentropic work is used to compute compressor's power 
    consumption";

  // Definition of outputs
  //
  output Modelica.SIunits.Efficiency etaEng(min=0, max=1, nominal= 0.9)
    "Overall engine efficiency";

  annotation (Documentation(revisions="<html><ul>
  <li>October 20, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This is a base model for overall engine efficiency models that are
  required for various compressor models. It defines some basic inputs
  and outputs that are commonly used by efficiency models and these
  inputs and outputs are summarised below:<br/>
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
  <tr>
    <td>
      <b>output</b>
    </td>
    <td>
      <code>η<sub>eng</sub></code>
    </td>
    <td>
      Overall engine efficiency
    </td>
  </tr>
</table>
</html>"));
end PartialEngineEfficiency;
