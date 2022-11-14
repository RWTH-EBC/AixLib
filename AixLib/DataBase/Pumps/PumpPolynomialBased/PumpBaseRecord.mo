within AixLib.DataBase.Pumps.PumpPolynomialBased;
record PumpBaseRecord "Definition of pump data"
  extends Modelica.Icons.Record;
  // *****************************************************
  // pumpTableFlowHeadCharacteristicRecord (paramFlowHead)
  // *****************************************************
  parameter Real[:, :] maxMinHeight=[
    -1, 16, 1;
     0, 16, 1;
     5, 12, 0.75;
    10, 0.5, 0.5]
      "maximum and minimum boundaries of pump (Q [m3/h], Hmax [m], Hmin [m])";
  parameter Modelica.Units.NonSI.AngularVelocity_rpm[:,:] maxMinSpeedCurves=[-1,
      nMax,nMin; 0,nMax,nMin; 5,0.5*nMax,nMin; 10,nMin,nMin] "maximum and minimum boundaries of pump speed 
     (Q [m3/h], nMax [rev/min], nMin [rev/min])";
  parameter Modelica.Units.NonSI.AngularVelocity_rpm nMin=0
    "minimum pump speed";
  parameter Modelica.Units.NonSI.AngularVelocity_rpm nMax=0
    "maximum pump speed";

  // *****************************************************
  // Coefficients for headFlowRpm function (HeadFlowRpmCharacteristic)
  // *****************************************************
  parameter Real[:, :] cHQN=[
    0, 0, 0;
    0, 0, 0;
    0, 0, 0]
      "coefficients for H = f(Q,n) = 
    sum_ij(cHQN[i,j] * Q^i * N^j)";

  // *****************************************************
  // Coefficients for powerCharacteristic function
  // *****************************************************
  parameter Real[:, :] cPQN=[
    0, 0, 0;
    0, 0, 0;
    0, 0, 0]
      "coefficients for P = f(Q,H) = sum_ij(cPQN[i,j] * Q^i * N^j)
    Wilo coefficients:
    c4,  c5,  c6,  c7,  c8;
     0,   0,  c1,   0,   0;
     0,  c2,   0,   0,   0;
    c3,   0,   0,   0,   0";

  // *****************************************************
  // Reference data from measurements
  // *****************************************************
  parameter Real[:, 5] referenceDataQHPN=[
    0, 0, 0, 0, 0;
    0, 0, 0, 0, 0;
    0, 0, 0, 0, 0]
      "Table with measurement and calculated data for reference.
    1. Q in m3/h,
    2. H in m,
    3. P in W,
    4. N in rev/min (power limited pump speed),
    5. N in rev/min (set point for pump speed)";
  annotation (
    Icon(graphics, coordinateSystem(preserveAspectRatio=false)),
    Diagram(graphics, coordinateSystem(preserveAspectRatio=false)),
    preferredView="text",
    Documentation(info="<html><h4>
  Parameters
</h4>
<p>
  The following section contains a list of parameters and descriptions.
</p>
<h5>
  maxMinHeight table
</h5>
<p>
  The table was taken from the original record
  <i>pumpTableFlowHeadCharacteristicRecord.</i>&#160;&#160;It defines
  the maximum and minimum pump curves for a given volume flow rate in
  m³/h. The columns are as follows:
</p>
<ol>
  <li>Volume flow rate in m3/h
  </li>
  <li>Head in m for maximum pump speed
  </li>
  <li>Head in m for minimum pump speed
  </li>
</ol>
<h5>
  maxMinSpeedCurves table
</h5>
<p>
  Using pump speed to control pump power instead of using pump head
  (<i>maxMinHeight</i>) is more meaningful for the new speed controlled
  pump. Also this is how it would be implemented in a regular pump. It
  defines the maximum and minimum pump speed curves for a given volume
  flow rate in m³/h. The columns are as follows:
</p>
<ol>
  <li>Volume flow rate in m3/h
  </li>
  <li>maximum pump speed
  </li>
  <li>minimum pump speed
  </li>
</ol>
<p>
  In order to limit the electric power consumption of the pump the
  speed needs to be reduced for high volume flow rates.
</p>
<p>
  \"maxMinSpeed\" refers to the original \"maxMinHeight\" parameter name.
  The Addition \"Curves\" should reflect that this is a matrix/table and
  not a scalar. This should reduce confusion in the presence of the two
  parameters <i>nMin</i> and <i>nMax</i> which only contain the
  absolute minumum and maximum speeds. Those parameters can be used in
  a controller where limits are given as scalar parameters for example.
</p>
<p>
  Notice that the default data have a range of 0 &lt;= Q &lt;= 10 m³/h!
  These values might be used in the models, for example in the form
  <span style=
  \"font-family: Courier New; color: #00aaff;\">max(pumpParam.maxMinSpeedCurves[:,1])</span>
  for initialization or nominal values. So take care that the table
  data really fit to your pump to avoid strange behaviour.
</p>
<h5>
  referenceDataQHPN
</h5>
<p>
  This table contains measurement data of volume flow (Q), pump head
  (H), power consumption (P), pump speeds real and setpoint (N) as well
  as the corresponding pump head as calculated by the abc-formula for
  reference. From this data the coefficients can be calculated and it
  can be verified that the pump data in the record all belong together.
  From this data one can also directly derive the maxMinHeight table.
</p>
<h5>
  Coefficients
</h5>
<p>
  The original pump model used polynomial functions of higher order in
  two dimensional space. For example the pump head could be calculated
  as a function of volume flow rate and pump speed:
</p>
<p>
  H = f(Q, n)=sum(c(i,j)*Q^i*n^j)
</p>
<p>
  with i and j being non-negative Integers. The functions were written
  down directly for each pump type as a replaceble function for
  example:
</p>
<p>
  <span style=
  \"font-family: Courier New;\">H&#160;:=&#160;0.1041&#160;-&#160;1.168*Q&#160;-&#160;0.0002526*n&#160;-&#160;0.01049*Q^2&#160;+&#160;0.002589*Q*n&#160;+&#160;5.614e-007*n^2
  ...</span>
</p>
<p>
  In the current record only stores the coefficients for the functions:
</p>
<ul>
  <li>
    <b>cHQN</b>:&#160;coefficients&#160;for&#160;H&#160;=&#160;f(Q,n)
  </li>
  <li>
    <b>cNQH</b>:&#160;coefficients&#160;for&#160;N&#160;=&#160;f(Q,H)
  </li>
  <li>
    <b>cPQN</b>:&#160;coefficients&#160;for&#160;P&#160;=&#160;f(Q,N)
  </li>
</ul>
<h5>
  Coefficients (Special Case of ABC-Formula)
</h5>
<p>
  A special type of formula has been \"developed\" for stability reasons.
  High order polynomials showed a good agreement with real pump data
  but lead to instable simulations (especially initialization) in
  certain situations. It was not clear what exactly would cause
  initialization problems with the high order polynomials but that low
  order polynomials could solve that problem with the disadvantage of
  lower acuracy of the pump curves. For example:
</p>
<p>
  H= a*n^2+b*Q*n+c*Q^2\"
</p>
<p>
  <br/>
  Using the c[i,j]-matrix this would become:
</p>
<p>
  H= c(0,2)*n^2+c(1,1)*Q*n+c(2,0)*Q^2
</p>
<p>
  <br/>
  Therefore, the ABC-Formula emerges as a special case out of the
  general formulation. In order to implement the latter formula
  directly to speed up the computation and also allow to switch between
  the precise and the not so precise pump curves without creating a
  second record for the same pump, there is a second set of
  coefficients:
</p>
<ul>
  <li>
    <b>cABCeq</b>: coefficients for H = f(Q,n) with only three elements
  </li>
</ul>
<p>
  Note that the computation of power must not be simplified as this is
  only a display variable in our simulations - no other states depend
  on power. Setting the default to [0,0,0] allows to check upon
  initialization if the selected coefficients can be used for
  simulation. So if the record misses a redeclaration of cABCeq and
  those coefficiens were selected be used, then an assert-warning will
  inform the user that with this record the selected calculation method
  (abc-formula) cannot be used. The same holds true for the matrix cHQN
  for example - it cannot be used if all the coefficients are at the
  default of zero.
</p>
<p>
  There are no coefficients for the inverse function N = f(Q, H) as the
  inverse can be calculated with the p-q-formula from cABCeq:
</p>
<p>
  n_1 = -b*Q/(2*a)+sqrt((b*Q/(2*a))^2 +(H-c*Q^2)/a)
</p>
<p>
  n_2 = -b*Q/(2*a)-sqrt((b*Q/(2*a))^2 +(H-c*Q^2)/a)
</p>
<ul>
  <li>2018-05-08 by Peter Matthes:<br/>
    Adds AixLib info template for records to the already existing
    documentation. Has to be finished.
  </li>
  <li>2018-02-15 by Peter Matthes:<br/>
    Deletes 'zero' rows from maxMinSpeedCurves and maxMinHeight tables.
    Reformats tables.
  </li>
  <li>2017-12-01 by Peter Matthes:<br/>
    * Adds parameter pumpManufacturerString to separate model type and
    manufacturer information.<br/>
    * Removes parameter cABCeq as that is included in cHQN already (if
    computed correctly).<br/>
    * Removes parameter cNQH as that is not necessary any more for the
    n_set algorithm (new pump model). For the old pump model the we can
    use the ABC coefficients and compute the inverse via
    p-q-formula.<br/>
    * Removes last column (H from ABC-formula) in referenceDataQHPN.
  </li>
  <li>2017-11-30 by Peter Matthes:<br/>
    Adds new parameter maxMinSpeedCurves for control of pump speed
    instead of pump head.
  </li>
  <li>2017-11-23 by Peter Matthes:<br/>
    Updates documentation for table formatting and cPQN coefficient
    order.
  </li>
  <li>2017-11-21 by Peter Matthes:<br/>
    Removed the full field table parameters HQnTable and PQnTable.
    Instead reference data from measurements will be stored in matrix
    referenceDataQHPN.
  </li>
  <li>2017-11-16 by Peter Matthes:<br/>
    Changed name of cHQNabc to cABCeq and deleted cNQHabc parameter.
    Updated documentation. Added nMin and nMax parameter. Adds default
    for maxMinHeight parameter
  </li>
  <li>2017-11-13 by Peter Matthes:<br/>
    Implemented
  </li>
</ul>
</html>"));
end PumpBaseRecord;
