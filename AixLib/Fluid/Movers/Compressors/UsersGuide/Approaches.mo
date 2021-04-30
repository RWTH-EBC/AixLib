within AixLib.Fluid.Movers.Compressors.UsersGuide;
class Approaches
  "Approaches implemented to calculate different efficiencies"
  extends Modelica.Icons.Information;

  class MechanicEfficiency "Mechanic Efficiencies"
    extends Modelica.Icons.Information;

    annotation (Documentation(revisions="<html><ul>
  <li>October 19, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>",   info="<html>
<p>
  Generally, two kinds of calculation approaches can be identified: A
  polynomial and a power approach. A generic polynomial approach is
  presented below:<br/>
  <br/>
  <code>η<sub>eng</sub> = corFact * sum(a[i]*P[i]^b[i] for i in
  1:nT)</code><br/>
  <br/>
  A generic power approach is presented below:<br/>
  <br/>
  <code>η<sub>eng</sub> = corFact * a * product(P[i]^b[i] for i in
  1:nT)</code><br/>
  <br/>
  All engine efficiency models presented in this library are based on a
  literature review. Therefore, the variable <code>corFact</code>
  allows a correction of the engine efficiency if the general modelling
  approach presented in the litarature differs from
  <code>η<sub>eng</sub> = Q̇<sub>ref</sub> / P<sub>el</sub></code> or
  from <code>η<sub>eng</sub> = Q̇<sub>refIse</sub> /
  P<sub>el</sub></code>, respectively.
</p>
<h4>
  Common model variables
</h4>
<p>
  Calculation procedures presented in the litarture have some variables
  in commen and these variables are presented below:<br/>
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
<h4>
  Polynomial engine efficiency models
</h4>
<p>
  Actually, four polynomial approaches are implemented in this package.
  To add further calculation procedures, just add its name in <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.Utilities.Types\">AixLib.Fluid.Movers.Compressors.Utilities.Types</a>
  and expand the <code>if-structure</code> defined in <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.Utilities.EngineEfficiency.PolynomialEngineEfficiency\">
  AixLib.Fluid.Movers.Compressors.Utilities.EngineEfficiency.PolynomialEngineEfficiency</a>.<br/>
</p>
<table summary=\"Polynomial approaches\" border=\"1\" cellspacing=\"0\"
cellpadding=\"2\" style=\"border-collapse:collapse;\">
  <tr>
    <th>
      Reference
    </th>
    <th>
      Formula
    </th>
    <th>
      Refrigerants
    </th>
    <th>
      Validity <code>n<sub>compressor</sub></code>
    </th>
    <th>
      Validity <code>Π<sub>pressure</sub></code>
    </th>
  </tr>
  <tr>
    <td>
      JahningEtAl2000
    </td>
    <td>
      <code>η<sub>eng</sub> = a1 + a2*exp(p<sub>Inl</sub>)^b2</code>
    </td>
    <td>
      Generic model
    </td>
    <td>
      <code>Generic model</code>
    </td>
    <td>
      <code>Generic model</code>
    </td>
  </tr>
  <tr>
    <td>
      DurprezEtAl2007
    </td>
    <td>
      <code>η<sub>eng</sub> = a1 + a2*π + a3*π^2 + a4*π^3 + a5*π^4 +
      a6*π^5 + a7*π^6</code>
    </td>
    <td>
      Generic model
    </td>
    <td>
      <code>Generic model</code>
    </td>
    <td>
      <code>Generic model</code>
    </td>
  </tr>
  <tr>
    <td>
      KinarbEtAl2010
    </td>
    <td>
      <code>η<sub>eng</sub> = a1 + a2*π + a3*π^2</code>
    </td>
    <td>
      Generic model
    </td>
    <td>
      <code>Generic model</code>
    </td>
    <td>
      <code>Generic model</code>
    </td>
  </tr>
  <tr>
    <td>
      Engelpracht2017
    </td>
    <td>
      <code>η<sub>eng</sub> = a1 + a2*π + a3*π^2 + a4*n*π + a5*n^2 +
      a6*π^2*n + a7*π*n^2 + a8*n^3 + a9*π^2n^2 + a10*π*π^3 +
      a11*n^4</code>
    </td>
    <td>
      Generic model
    </td>
    <td>
      <code>0 - 120</code>
    </td>
    <td>
      <code>1 - 10</code>
    </td>
  </tr>
</table>
<h4>
  Power engine efficiency models
</h4>
<p>
  Actually, one power approache is implemented in this package. To add
  further calculation procedures, just add its name in <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.Utilities.Types\">AixLib.Fluid.Movers.Compressors.Utilities.Types</a>
  and expand the <code>if-structure</code> defined in <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.Utilities.EngineEfficiency.PowerEngineEfficiency\">
  AixLib.Fluid.Movers.Compressors.Utilities.EngineEfficiency.PowerEngineEfficiency</a>.<br/>
</p>
<table summary=\"Power approaches\" border=\"1\" cellspacing=\"0\"
cellpadding=\"2\" style=\"border-collapse:collapse;\">
  <tr>
    <th>
      Reference
    </th>
    <th>
      Formula
    </th>
    <th>
      Refrigerants
    </th>
    <th>
      Validity <code>n<sub>compressor</sub></code>
    </th>
    <th>
      Validity <code>Π<sub>pressure</sub></code>
    </th>
  </tr>
  <tr>
    <td>
      MendozaMirandaEtAl2016
    </td>
    <td>
      <code>η<sub>eng</sub> = a1 * π^b1 * (n<sub>ref</sub>/n)^b2 *
      (1/((T<sub>Inl</sub>+T<sub>OutIse</sub>)/2-T<sub>Out</sub>))^b3 *
      (M<sub>ref</sub>/M)^b4</code>
    </td>
    <td>
      R134a,R450a,R1324yf,R1234ze(E)
    </td>
    <td>
      <code>0 - 50</code>
    </td>
    <td>
      <code>1 - 6</code>
    </td>
  </tr>
</table>
</html>"));
  end MechanicEfficiency;

  class VolumetricEfficiency "Volumetric Efficiencies"
    extends Modelica.Icons.Information;

    annotation (Documentation(revisions="<html><ul>
  <li>October 19, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>",   info="<html>
<p>
  Generally, two kinds of calculation approaches can be identified: A
  polynomial and a power approach. A generic polynomial approach is
  presented below:<br/>
  <br/>
  <code>η<sub>vol</sub> = corFact * sum(a[i]*P[i]^b[i] for i in
  1:nT)</code><br/>
  <br/>
  A generic power approach is presented below:<br/>
  <br/>
  <code>η<sub>vol</sub> = corFact * a * product(P[i]^b[i] for i in
  1:nT)</code><br/>
  <br/>
  All volumetric efficiency models presented in this library are based
  on a literature review. Therefore, the variable <code>corFact</code>
  allows a correction of the volumetric efficiency if the general
  modelling approach presented in the litarature differs from
  <code>η<sub>vol</sub> = V̇<sub>ide</sub> / V̇<sub>rea</sub></code>.
</p>
<h4>
  Common model variables
</h4>
<p>
  Calculation procedures presented in the litarture have some variables
  in commen and these variables are presented below:<br/>
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
<h4>
  Polynomial volumetric efficiency models
</h4>
<p>
  Actually, four polynomial approaches are implemented in this package.
  To add further calculation procedures, just add its name in <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.Utilities.Types\">AixLib.Fluid.Movers.Compressors.Utilities.Types</a>
  and expand the <code>if-structure</code> defined in <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency.PolynomialVolumetricEfficiency\">
  AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency.PolynomialVolumetricEfficiency</a>.<br/>
</p>
<table summary=\"Polynomial approaches\" border=\"1\" cellspacing=\"0\"
cellpadding=\"2\" style=\"border-collapse:collapse;\">
  <tr>
    <th>
      Reference
    </th>
    <th>
      Formula
    </th>
    <th>
      Refrigerants
    </th>
    <th>
      Validity <code>n<sub>compressor</sub></code>
    </th>
    <th>
      Validity <code>Π<sub>pressure</sub></code>
    </th>
  </tr>
  <tr>
    <td>
      DarrAndCrawford1992
    </td>
    <td>
      <code>η<sub>vol</sub> = a1 + a2*n -
      a3*epsRef*(ρ<sub>inlIse</sub>/ρ<sub>inl</sub>-1) -
      a4*n*(ρ<sub>inlIse</sub>/ρ<sub>inl</sub>-1)</code>
    </td>
    <td>
      R134a
    </td>
    <td>
      <code>40 - 75</code>
    </td>
    <td>
      <code>3 - 10</code>
    </td>
  </tr>
  <tr>
    <td>
      Karlsson2007
    </td>
    <td>
      <code>η<sub>vol</sub> = a1*T<sub>inl</sub>*π + a2*π + a3 +
      a4*T<sub>inl</sub> + a5*n + a6*n^2</code>
    </td>
    <td>
      R407c
    </td>
    <td>
      <code>No information</code>
    </td>
    <td>
      <code>No information</code>
    </td>
  </tr>
  <tr>
    <td>
      KinarbEtAl2010
    </td>
    <td>
      <code>η<sub>vol</sub> = a1 + a2*π</code>
    </td>
    <td>
      Generic model
    </td>
    <td>
      <code>Generic model</code>
    </td>
    <td>
      <code>Generic model</code>
    </td>
  </tr>
  <tr>
    <td>
      ZhouEtAl2010
    </td>
    <td>
      <code>η<sub>vol</sub> = 1 + a1 - a2*π^(1/κ)</code>
    </td>
    <td>
      Generic model
    </td>
    <td>
      <code>Generic model</code>
    </td>
    <td>
      <code>Generic model</code>
    </td>
  </tr>
  <tr>
    <td>
      Li2013
    </td>
    <td>
      <code>η<sub>vol</sub> = η<sub>volRef</sub> * (a1 +
      a2*(n/n<sub>ref</sub>) + a3*(n/n<sub>ref</sub>)^2)</code>
    </td>
    <td>
      R22,R134a
    </td>
    <td>
      <code>30 - 120</code>
    </td>
    <td>
      <code>4 - 12</code>
    </td>
  </tr>
  <tr>
    <td>
      HongtaoLaughmannEtAl2017
    </td>
    <td>
      <code>η<sub>vol</sub> = a1 + a2*(n/n<sub>ref</sub>) +
      a3*(n/n<sub>ref</sub>)^2 + a4*π + a5*(n/n<sub>ref</sub>)*π +
      a6*(n/n<sub>ref</sub>)^2*π + a7*π^2 + a8*(n/n<sub>ref</sub>)*π^2
      + a9*(n/n<sub>ref</sub>)^2*π^2 + a10*p<sub>out</sub> +
      a11*(n/n<sub>ref</sub>)*p<sub>out</sub> +
      a12*(n/n<sub>ref</sub>)^2*p<sub>out</sub> - a13*p<sub>inl</sub> -
      a14*(n/n<sub>ref</sub>)*p<sub>inl</sub> -
      a15*(n/n<sub>ref</sub>)^2*p<sub>inl</sub> +
      a16*p<sub>inl</sub>*p<sub>out</sub> +
      a17*(n/n<sub>ref</sub>)*p<sub>inl</sub>*p<sub>out</sub> +
      a18*(n/n<sub>ref</sub>)^2*p<sub>inl</sub>*p<sub>out</sub> +
      a19*(n/n<sub>ref</sub>)^3*p<sub>inl</sub>*p<sub>out</sub> +
      a20*(n/n<sub>ref</sub>)^4*p<sub>inl</sub>*p<sub>out</sub> -
      a21*p<sub>inl</sub>^2 - a22*(n/n<sub>ref</sub>)*p<sub>inl</sub>^2
      - a23*(n/n<sub>ref</sub>)^2*p<sub>inl</sub>^2 -
      a24*(n/n<sub>ref</sub>)^3*p<sub>inl</sub>^2 -
      a25*(n/n<sub>ref</sub>)^4*p<sub>inl</sub>^2</code>
    </td>
    <td>
      Generic model
    </td>
    <td>
      <code>Generic model</code>
    </td>
    <td>
      <code>Generic model</code>
    </td>
  </tr>
  <tr>
    <td>
      Koerner2017
    </td>
    <td>
      <code>η<sub>vol</sub> = a1*π^b1</code>
    </td>
    <td>
      R410a
    </td>
    <td>
      <code>50 - 120</code>
    </td>
    <td>
      <code>1 - 10</code>
    </td>
  </tr>
  <tr>
    <td>
      Engelpracht2017
    </td>
    <td>
      <code>η<sub>vol</sub> = a1 + a2*((π-c1)/c2) +
      a3*((T<sub>inl</sub>-c3)/c4)*((π-c1)/c2) +
      a4*((T<sub>inl</sub>-c3)/c4) + a5*((n-c5)/c6) +
      a6*((n-c5)/c6)^2</code>
    </td>
    <td>
      Generic model
    </td>
    <td>
      <code>0 - 120</code>
    </td>
    <td>
      <code>1 - 10</code>
    </td>
  </tr>
</table>
<h4>
  Power volumetric efficiency models
</h4>
<p>
  Actually, one power approache is implemented in this package. To add
  further calculation procedures, just add its name in <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.Utilities.Types\">AixLib.Fluid.Movers.Compressors.Utilities.Types</a>
  and expand the <code>if-structure</code> defined in <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency.PowerVolumetricEfficiency\">
  AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency.PowerVolumetricEfficiency</a>.<br/>
</p>
<table summary=\"Power approaches\" border=\"1\" cellspacing=\"0\"
cellpadding=\"2\" style=\"border-collapse:collapse;\">
  <tr>
    <th>
      Reference
    </th>
    <th>
      Formula
    </th>
    <th>
      Refrigerants
    </th>
    <th>
      Validity <code>n<sub>compressor</sub></code>
    </th>
    <th>
      Validity <code>Π<sub>pressure</sub></code>
    </th>
  </tr>
  <tr>
    <td>
      MendozaMirandaEtAl2016
    </td>
    <td>
      <code>η<sub>vol</sub> = a1 * π^b1 *
      (π^1.5*n^3*V<sub>dis</sub>)^b2 * (M<sub>ref</sub>/M)^b3</code>
    </td>
    <td>
      R134a,R450a,R1324yf,R1234ze(E)
    </td>
    <td>
      <code>0 - 50</code>
    </td>
    <td>
      <code>1 - 6</code>
    </td>
  </tr>
</table>
</html>"));
  end VolumetricEfficiency;

  class IsentropicEfficiency "Isentropic Efficiencies"
    extends Modelica.Icons.Information;

    annotation (Documentation(revisions="<html><ul>
  <li>October 19, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>",   info="<html>
<p>
  Generally, two kinds of calculation approaches can be identified: A
  polynomial and a power approach. A generic polynomial approach is
  presented below:<br/>
  <br/>
  <code>η<sub>ise</sub> = corFact * sum(a[i]*P[i]^b[i] for i in
  1:nT)</code><br/>
  <br/>
  A generic power approach is presented below:<br/>
  <br/>
  <code>η<sub>ise</sub> = corFact * a * product(P[i]^b[i] for i in
  1:nT)</code><br/>
  <br/>
  All isentropic efficiency models presented in this library are based
  on a literature review. Therefore, the variable <code>corFact</code>
  allows a correction of the isentropic efficiency if the general
  modelling approach presented in the litarature differs from
  <code>η<sub>ise</sub> = (h<sub>outIse</sub> - h<sub>inl</sub>) /
  (h<sub>out</sub> - h<sub>inl</sub>)</code>.
</p>
<h4>
  Common model variables
</h4>
<p>
  Calculation procedures presented in the litarture have some variables
  in commen and these variables are presented below:<br/>
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
<h4>
  Polynomial isentropic efficiency models
</h4>
<p>
  Actually, three polynomial approaches are implemented in this
  package. To add further calculation procedures, just add its name in
  <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.Utilities.Types\">AixLib.Fluid.Movers.Compressors.Utilities.Types</a>
  and expand the <code>if-structure</code> defined in <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency.PolynomialIsentropicEfficiency\">
  AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency.PolynomialIsentropicEfficiency</a>.<br/>
</p>
<table summary=\"Polynomial approaches\" border=\"1\" cellspacing=\"0\"
cellpadding=\"2\" style=\"border-collapse:collapse;\">
  <tr>
    <th>
      Reference
    </th>
    <th>
      Formula
    </th>
    <th>
      Refrigerants
    </th>
    <th>
      Validity <code>n<sub>compressor</sub></code>
    </th>
    <th>
      Validity <code>Π<sub>pressure</sub></code>
    </th>
  </tr>
  <tr>
    <td>
      DarrAndCrawford1992
    </td>
    <td>
      <code>η<sub>ise</sub> = a1 + a2*n + a3/ρ<sub>inlet</sub></code>
    </td>
    <td>
      R134a
    </td>
    <td>
      <code>40 - 75</code>
    </td>
    <td>
      <code>3 - 10</code>
    </td>
  </tr>
  <tr>
    <td>
      Karlsson2007
    </td>
    <td>
      <code>η<sub>ise</sub> = a1 + a2*π + a3*π^2 + a4*n + a5*n^2</code>
    </td>
    <td>
      R407c
    </td>
    <td>
      <code>No information</code>
    </td>
    <td>
      <code>No information</code>
    </td>
  </tr>
  <tr>
    <td>
      Engelpracht2017
    </td>
    <td>
      <code>η<sub>ise</sub> = a1 + a2*n + a3*n^3 + a5*π^2</code>
    </td>
    <td>
      Generic model
    </td>
    <td>
      <code>0 - 120</code>
    </td>
    <td>
      <code>1 - 10</code>
    </td>
  </tr>
</table>
<h4>
  Power isentropic efficiency models
</h4>
<p>
  Actually, one power approache is implemented in this package. To add
  further calculation procedures, just add its name in <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.Utilities.Types\">AixLib.Fluid.Movers.Compressors.Utilities.Types</a>
  and expand the <code>if-structure</code> defined in <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency.PowerIsentropicEfficiency\">
  AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency.PowerIsentropicEfficiency</a>.<br/>
</p>
<table summary=\"Power approaches\" border=\"1\" cellspacing=\"0\"
cellpadding=\"2\" style=\"border-collapse:collapse;\">
  <tr>
    <th>
      Reference
    </th>
    <th>
      Formula
    </th>
    <th>
      Refrigerants
    </th>
    <th>
      Validity <code>n<sub>compressor</sub></code>
    </th>
    <th>
      Validity <code>Π<sub>pressure</sub></code>
    </th>
  </tr>
  <tr>
    <td>
      MendozaMirandaEtAl2016
    </td>
    <td>
      <code>η<sub>ise</sub> = a1 * π^b1 * (n<sub>ref</sub>/n)^b2 *
      (n^3*V<sub>dis</sub>/dh<sub>ise</sub>^1.5)^b3 *
      (1/((T<sub>inl</sub>+T<sub>outIse</sub>)/2-T<sub>out</sub>))^b4</code>
    </td>
    <td>
      R134a,R450a,R1324yf,R1234ze(E)
    </td>
    <td>
      <code>0 - 50</code>
    </td>
    <td>
      <code>1 - 6</code>
    </td>
  </tr>
</table>
</html>"));
  end IsentropicEfficiency;

  annotation (Documentation(revisions="<html><ul>
  <li>October 19, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  Compressor models implemented in this library often use three
  different efficiencies to calculate the mass flow rate, thermodynamic
  change of state and power consumption of the compressor. In the
  following, all efficiency models implemented in this library are
  shortly summarised. Furthermore, all compressor models have a
  parameter to calculate transient behaviour of changing the rotational
  speed. This approach is also summarised in this information section.
</p>
<h4>
  Efficiency modeling approaches
</h4>
<p>
  Actually, three different efficiency models are suggested and the
  modelling approaches of these efficiencies are shortly characterised
  below:<br/>
</p>
<table summary=\"Efficiencies\" border=\"1\" cellspacing=\"0\" cellpadding=
\"2\" style=\"border-collapse:collapse;\">
  <tr>
    <th>
      Efficiency
    </th>
    <th>
      Formula
    </th>
    <th>
      Comment
    </th>
  </tr>
  <tr>
    <td>
      <b>Engine</b>
    </td>
    <td>
      <code>η<sub>eng</sub> = Q̇<sub>ref</sub> / P<sub>el</sub></code>
    </td>
    <td>
      Used for calculation of compressor's power consumption
    </td>
  </tr>
  <tr>
    <td>
      <b>Isentropic</b>
    </td>
    <td>
      <code>η<sub>ise</sub> = (h<sub>outIse</sub> - h<sub>inl</sub>) /
      (h<sub>out</sub> - h<sub>inl</sub>)</code>
    </td>
    <td>
      Used for calculation of thermodynamic change of state
    </td>
  </tr>
  <tr>
    <td>
      <b>Volumetric</b>
    </td>
    <td>
      <code>η<sub>vol</sub> = V̇<sub>ide</sub> /
      V̇<sub>rea</sub></code>
    </td>
    <td>
      Used for calculation of mass flow rate
    </td>
  </tr>
</table>
<p>
  These efficiency models are stored in <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.Utilities.EngineEfficiency\">
  AixLib.Fluid.Movers.Compressors.Utilities.EngineEfficiency</a>,
  <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency\">
  AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency</a>
  and <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency\">
  AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency</a>.
  Therefore, the calculation procedure of the efficiencies are
  introduced as replaceable models and must be defined by the User.
  Further information is given in the following sections:
</p>
<ol>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.Movers.Compressors.UsersGuide.Approaches.MechanicEfficiency\">
    Engine efficiencies</a>
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.Movers.Compressors.UsersGuide.Approaches.VolumetricEfficiency\">
    Volumetric efficiencies</a>
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.Movers.Compressors.UsersGuide.Approaches.IsentropicEfficiency\">
    Isentropic efficiencies</a>
  </li>
</ol>
<h4>
  Naming and abbreviations
</h4>
<p>
  In the following, a guideline of naming efficiency models is
  summarised:
</p>
<p style=\"margin-left: 30px;\">
  <i>Approach of calculating efficiency</i> _ <i>Valid refrigerants</i>
  _ <i>Displacement volume</i> _ <i>Type of compressor</i>
</p>
<ol>
  <li>
    <u>Approach:</u> Approach of calculating efficiency, e.g.
    polynomial or power.
  </li>
  <li>
    <u>Refrigerant:</u> Refrigerants the efficiency model is valid for,
    e.g. R134a or R410a.
  </li>
  <li>
    <u>Displacement volume:</u> Displacement volume the efficiency
    model is valid for, e.g. 170cm³.
  </li>
  <li>
    <u>Type:</u> Type of compressor, e.g. scroll compressor.
  </li>
</ol>
<h4>
  Transient behaviour
</h4>
<p>
  The base model has a parameter <code>useInpFil</code> that is used to
  model the compressors's transient behaviour while changing rotational
  speed. Generally, this approach uses the same modeling attempt as the
  stat-up and shut-down transients introtuced for flow machines (see
  <a href=
  \"modelica://AixLib.Fluid.Movers.UsersGuide\">AixLib.Fluid.Movers.UsersGuide</a>).
  Therefore, just the parameter's affections are presented here:
</p>
<ol>
  <li>If <code>useInpFil=false</code>, then the input signal
  <code>opeSet.y</code> is equal to the compressor's rotational speed.
  Thus, a step change in the input signal causes a step change in the
  rotational speed.
  </li>
  <li>If <code>useInpFil=true</code>, which is the default, then the
  rotational speed is equal to the output of a filter. This filter is
  implemented as a 2nd order differential equation. Thus, a step change
  in the compressor's input signal will cause a gradual change in the
  rotational speed. The filter has a parameter <code>risTim</code>,
  which by default is set to <i>1</i> second. The rise time is the time
  required to reach <i>99.6%</i> of the full rotational speed, or, if
  the compressor is shut-down, to reach a rotational speed of
  <i>0.4%</i>.
  </li>
</ol>
</html>"));
end Approaches;
