within AixLib.Media;

package Air

  "Package with moist air model that decouples pressure and temperature"

  extends Modelica.Media.Interfaces.PartialCondensingGases(

     mediumName="Air",

     final substanceNames={"water", "air"},

     final reducedX=true,

     final singleState = false,

     reference_X={0.01,0.99},

     final fluidConstants = {Modelica.Media.IdealGases.Common.FluidData.H2O,

                             Modelica.Media.IdealGases.Common.FluidData.N2},

     reference_T=273.15,

     reference_p=101325,

     AbsolutePressure(start=p_default),

     Temperature(start=T_default));

  extends Modelica.Icons.Package;



  constant Integer Water=1

    "Index of water (in substanceNames, massFractions X, etc.)";

  constant Integer Air=2

    "Index of air (in substanceNames, massFractions X, etc.)";



  constant AbsolutePressure pStp = reference_p

    "Pressure for which fluid density is defined";

  constant Density dStp = 1.2 "Fluid density at pressure pStp";



  // Redeclare ThermodynamicState to avoid the warning

  // "Base class ThermodynamicState is replaceable"

  // during model check

  redeclare record extends ThermodynamicState

    "ThermodynamicState record for moist air"

  end ThermodynamicState;



  // There must not be any stateSelect=StateSelect.prefer for

  // the pressure.

  // Otherwise, translateModel("Buildings.Fluid.FMI.ExportContainers.Examples.FMUs.ResistanceVolume")

  // will fail as Dymola does an index reduction and outputs

  //   Differentiated the equation

  //   vol.dynBal.medium.p+res.dp-inlet.p = 0.0;

  //   giving

  //   der(vol.dynBal.medium.p)+der(res.dp) = der(inlet.p);

  //

  //   The model requires derivatives of some inputs as listed below:

  //   1 inlet.m_flow

  //   1 inlet.p

  // Therefore, the statement

  //   p(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default)

  // has been removed.

  redeclare replaceable model extends BaseProperties(

    Xi(each stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),

    T(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),

    final standardOrderComponents=true) "Base properties"



  protected

    constant Modelica.SIunits.MolarMass[2] MMX = {steam.MM,dryair.MM}

      "Molar masses of components";



    MassFraction X_steam "Mass fraction of steam water";

    MassFraction X_air "Mass fraction of air";

    Modelica.SIunits.TemperatureDifference dT(start=T_default-reference_T)

      "Temperature difference used to compute enthalpy";

  equation

    assert(T >= 200.0 and T <= 423.15, "

Temperature T is not in the allowed range

200.0 K <= (T ="

               + String(T) + " K) <= 423.15 K

required from medium model \""     + mediumName + "\".");



    MM = 1/(Xi[Water]/MMX[Water]+(1.0-Xi[Water])/MMX[Air]);



    X_steam  = Xi[Water]; // There is no liquid in this medium model

    X_air    = 1-Xi[Water];



    dT = T - reference_T;

    h = dT*dryair.cp * X_air +

       (dT * steam.cp + h_fg) * X_steam;

    R = dryair.R*X_air + steam.R*X_steam;



    // Equation for ideal gas, from h=u+p*v and R*T=p*v, from which follows that  u = h-R*T.

    // u = h-R*T;

    // However, in this medium, the gas law is d/dStp=p/pStp, from which follows using h=u+pv that

    // u= h-p*v = h-p/d = h-pStp/dStp

    u = h-pStp/dStp;



    // In this medium model, the density depends only

    // on temperature, but not on pressure.

    //  d = p/(R*T);

    d/dStp = p/pStp;



    state.p = p;

    state.T = T;

    state.X = X;

  end BaseProperties;



redeclare function density "Gas density"

  extends Modelica.Icons.Function;

  input ThermodynamicState state;

  output Density d "Density";

algorithm

  d :=state.p*dStp/pStp;

  annotation(smoothOrder=5,

  Inline=true,

  Documentation(info="<html>
Density
is
computed
from
pressure,
temperature
and
composition
in
the
thermodynamic
state
record
applying
the
ideal
gas
law.
</html>",revisions="<html>
<p>
  This
  function
  returns
  the
  dynamic
  viscosity.
</p>
<h4>
  Implementation
</h4>
<p>
  The
  function
  is
  based
  on
  the
  5th
  order
  polynomial
  of
  <a href=\"modelica://Modelica.Media.Air.MoistAir.dynamicViscosity\">
  Modelica.Media.Air.MoistAir.dynamicViscosity</a>.
  However,
  for
  the
  typical
  range
  of
  temperatures
  encountered
  in
  building
  applications,
  a
  linear
  function
  sufficies.
  This
  implementation
  is
  therefore
  the
  above
  5th
  order
  polynomial,
  linearized
  around
  <i>
  20</i>°C.
  The
  relative
  error
  of
  this
  linearization
  is
  <i>
  0.4</i>%
  at
  <i>
  -20</i>°C,
  and
  less
  then
  <i>
  0.2</i>%
  between
  <i>
  -5</i>°C
  and
  <i>
  +50</i>°C.
</p>
<ul>
  <li>
  December
  19,
  2013,
  by
  Michael
  Wetter:<br/>

    First
    implementation.
  </li>
</ul>The
ideal
gas
constant
for
moist
air
is
computed
from
<a href=\"modelica://Modelica.Media.Air.MoistAir.ThermodynamicState\">
thermodynamic
state</a>
assuming
that
all
water
is
in
the
gas
phase.
Pressure
is
returned
from
the
thermodynamic
state
record
input
as
a
simple
assignment.
<p>
  This
  function
  returns
  the
  isobaric
  expansion
  coefficient
  at
  constant
  pressure,
  which
  is
  zero
  for
  this
  medium.
  The
  isobaric
  expansion
  coefficient
  at
  constant
  pressure
  is
</p>
<p align=\"center\"
style=\"font-style:italic;\">
  β<sub>p</sub>
  =
  -
  1
  ⁄
  v
  &#160;
  (∂
  v
  ⁄
  ∂
  T)<sub>p</sub>
  =
  0,
</p>
<p>
  where
  <i>
  v</i>
  is
  the
  specific
  volume,
  <i>
  T</i>
  is
  the
  temperature
  and
  <i>
  p</i>
  is
  the
  pressure.
</p>
<ul>
  <li>
  December
  18,
  2013,
  by
  Michael
  Wetter:<br/>

    First
    implementation.
  </li>
</ul>
<p>
  This
  function
  returns
  the
  isothermal
  compressibility
  coefficient.
  The
  isothermal
  compressibility
  is
</p>
<p align=\"center\"
style=\"font-style:italic;\">
  κ<sub>T</sub>
  =
  -1
  ⁄
  v
  &#160;
  (∂
  v
  ⁄
  ∂
  p)<sub>T</sub>
  =
  -1
  ⁄
  p,
</p>
<p>
  where
  <i>
  v</i>
  is
  the
  specific
  volume,
  <i>
  T</i>
  is
  the
  temperature
  and
  <i>
  p</i>
  is
  the
  pressure.
</p>
<ul>
  <li>
  December
  18,
  2013,
  by
  Michael
  Wetter:<br/>

    First
    implementation.
  </li>
</ul>
<p>
  This
  function
  computes
  the
  specific
  entropy.
</p>
<p>
  The
  specific
  entropy
  of
  the
  mixture
  is
  obtained
  from
</p>
<p align=\"center\"
style=\"font-style:italic;\">
  s
  =
  s<sub>s</sub>
  +
  s<sub>m</sub>,
</p>
<p>
  where
  <i>
  s<sub>s</sub></i>
  is
  the
  entropy
  change
  due
  to
  the
  state
  change
  (relative
  to
  the
  reference
  temperature)
  and
  <i>
  s<sub>m</sub></i>
  is
  the
  entropy
  change
  due
  to
  mixing
  of
  the
  dry
  air
  and
  water
  vapor.
</p>
<p>
  The
  entropy
  change
  due
  to
  change
  in
  state
  is
  obtained
  from
</p>
<p align=\"center\"
style=\"font-style:italic;\">
  s<sub>s</sub>
  =
  c<sub>v</sub>
  ln(T/T<sub>0</sub>)
  +
  R
  ln(v/v<sub>0</sub>)<br/>

  =
  c<sub>v</sub>
  ln(T/T<sub>0</sub>)
  +
  R
  ln(ρ<sub>0</sub>/ρ)
</p>
<p>
  If
  we
  assume
  <i>
  ρ
  =
  p<sub>0</sub>/(R
  T)</i>,
  and
  because
  <i>
  c<sub>p</sub>
  =
  c<sub>v</sub>
  +
  R</i>,
  we
  can
  write
</p>
<p align=\"center\"
style=\"font-style:italic;\">
  s<sub>s</sub>
  =
  c<sub>v</sub>
  ln(T/T<sub>0</sub>)
  +
  R
  ln(T/T<sub>0</sub>)<br/>

  =c<sub>p</sub>
  ln(T/T<sub>0</sub>).
</p>
<p>
  Next,
  the
  entropy
  of
  mixing
  is
  obtained
  from
  a
  reversible
  isothermal
  expansion
  process.
  Hence,
</p>
<p align=\"center\"
style=\"font-style:italic;\">
  s<sub>m</sub>
  =
  -R
  ∑<sub>i</sub>(
  X<sub>i</sub>
  ⁄
  M<sub>i</sub>
  ln(Y<sub>i</sub>
  p/p<sub>0</sub>)),
</p>
<p>
  where
  <i>
  R</i>
  is
  the
  gas
  constant,
  <i>
  X</i>
  is
  the
  mass
  fraction,
  <i>
  M</i>
  is
  the
  molar
  mass,
  and
  <i>
  Y</i>
  is
  the
  mole
  fraction.
</p>
<p>
  To
  obtain
  the
  state
  for
  a
  given
  pressure,
  entropy
  and
  mass
  fraction,
  use
  <a href=\"modelica://AixLib.Media.Air.setState_psX\">
  AixLib.Media.Air.setState_psX</a>.
</p>
<h4>
  Limitations
</h4>
<p>
  This
  function
  is
  only
  valid
  for
  a
  relative
  humidity
  below
  100%.
</p>
<ul>
  <li>
  November
  27,
  2013,
  by
  Michael
  Wetter:<br/>

    First
    implementation.
  </li>
</ul>
<p>
  This
  function
  returns
  the
  partial
  derivative
  of
  density
  with
  respect
  to
  pressure
  at
  constant
  temperature.
</p>
<ul>
  <li>
  December
  18,
  2013,
  by
  Michael
  Wetter:<br/>

    First
    implementation.
  </li>
</ul>
<p>
  This
  function
  computes
  the
  derivative
  of
  density
  with
  respect
  to
  temperature
  at
  constant
  pressure.
</p>
<ul>
  <li>
  December
  18,
  2013,
  by
  Michael
  Wetter:<br/>

    First
    implementation.
  </li>
</ul>
<p>
  This
  function
  returns
  the
  partial
  derivative
  of
  density
  with
  respect
  to
  mass
  fraction.
  This
  value
  is
  zero
  because
  in
  this
  medium,
  density
  is
  proportional
  to
  pressure,
  but
  independent
  of
  the
  species
  concentration.
</p>
<ul>
  <li>
  December
  18,
  2013,
  by
  Michael
  Wetter:<br/>

    First
    implementation.
  </li>
</ul>
<p>
  The
  <a href=\"modelica://Modelica.Media.Interfaces.PartialMixtureMedium.ThermodynamicState\">
  thermodynamic
  state
  record</a>
  is
  computed
  from
  density
  <code>
  d</code>,
  temperature
  <code>
  T</code>
  and
  composition
  <code>
  X</code>.
</p>The
<a href=\"modelica://Modelica.Media.Interfaces.PartialMixtureMedium.ThermodynamicState\">
thermodynamic
state
record</a>
is
computed
from
pressure
p,
specific
enthalpy
h
and
composition
X.
The
<a href=\"modelica://Modelica.Media.Interfaces.PartialMixtureMedium.ThermodynamicState\">
thermodynamic
state
record</a>
is
computed
from
pressure
p,
temperature
T
and
composition
X.
<p>
  This
  function
  returns
  the
  thermodynamic
  state
  based
  on
  pressure,
  specific
  entropy
  and
  mass
  fraction.
</p>
<p>
  The
  state
  is
  computed
  by
  symbolically
  solving
  <a href=\"modelica://AixLib.Media.Air.specificEntropy\">
  AixLib.Media.Air.specificEntropy</a>
  for
  temperature.
</p>
<ul>
  <li>
  November
  27,
  2013,
  by
  Michael
  Wetter:<br/>

    First
    implementation.
  </li>
</ul>Specific
enthalpy
as
a
function
of
temperature
and
species
concentration.
The
pressure
is
input
for
compatibility
with
the
medium
models,
but
the
specific
enthalpy
is
independent
of
the
pressure.
<ul>
  <li>
  April
  30,
  2015,
  by
  Filip
  Jorissen
  and
  Michael
  Wetter:<br/>

    Added
    <code>
    Inline=true</code>
    for
    <a href=\"https://github.com/iea-annex60/modelica-annex60/issues/227\">
    issue
    227</a>.
  </li>
</ul>
<p>
  This
  function
  computes
  the
  specific
  enthalpy
  for
  an
  isentropic
  state
  change
  from
  the
  temperature
  that
  corresponds
  to
  the
  state
  <code>
  refState</code>
  to
  <code>
  reference_T</code>.
</p>
<ul>
  <li>
  December
  18,
  2013,
  by
  Michael
  Wetter:<br/>

    First
    implementation.
  </li>
</ul>Temperature
is
returned
from
the
thermodynamic
state
record
input
as
a
simple
assignment.
<p>
  This
  function
  returns
  the
  molar
  mass.
</p>
<ul>
  <li>
  December
  18,
  2013,
  by
  Michael
  Wetter:<br/>

    First
    implementation.
  </li>
</ul>Temperature
as
a
function
of
specific
enthalpy
and
species
concentration.
The
pressure
is
input
for
compatibility
with
the
medium
models,
but
the
temperature
is
independent
of
the
pressure.
<ul>
  <li>
  April
  30,
  2015,
  by
  Filip
  Jorissen
  and
  Michael
  Wetter:<br/>

    Added
    <code>
    Inline=true</code>
    for
    <a href=\"https://github.com/iea-annex60/modelica-annex60/issues/227\">
    issue
    227</a>.
  </li>
</ul>
<p>
  This
  data
  record
  contains
  the
  coefficients
  for
  perfect
  gases.
</p>
<ul>
  <li>
  September
  12,
  2014,
  by
  Michael
  Wetter:<br/>

    Corrected
    the
    wrong
    location
    of
    the
    <code>
    preferredView</code>
    and
    the
    <code>
    revisions</code>
    annotation.
  </li>
  <li>
  November
  21,
  2013,
  by
  Michael
  Wetter:<br/>

    First
    implementation.
  </li>
</ul>
<p>
  This
  medium
  package
  models
  moist
  air
  using
  a
  gas
  law
  in
  which
  pressure
  and
  temperature
  are
  independent,
  which
  often
  leads
  to
  significantly
  faster
  and
  more
  robust
  computations.
  The
  specific
  heat
  capacities
  at
  constant
  pressure
  and
  at
  constant
  volume
  are
  constant.
  The
  air
  is
  assumed
  to
  be
  not
  saturated.
</p>
<p>
  This
  medium
  uses
  the
  gas
  law
</p>
<p align=\"center\"
style=\"font-style:italic;\">
  ρ/ρ<sub>stp</sub>
  =
  p/p<sub>stp</sub>,
</p>
<p>
  where
  <i>
  p<sub>std</sub></i>
  and
  <i>
  ρ<sub>stp</sub></i>
  are
  constant
  reference
  temperature
  and
  density,
  rathern
  than
  the
  ideal
  gas
  law
</p>
<p align=\"center\"
style=\"font-style:italic;\">
  ρ
  =
  p
  ⁄(R
  T),
</p>
<p>
  where
  <i>
  R</i>
  is
  the
  gas
  constant
  and
  <i>
  T</i>
  is
  the
  temperature.
</p>
<p>
  This
  formulation
  often
  leads
  to
  smaller
  systems
  of
  nonlinear
  equations
  because
  equations
  for
  pressure
  and
  temperature
  are
  decoupled.
  Therefore,
  if
  air
  inside
  a
  control
  volume
  such
  as
  room
  air
  is
  heated,
  it
  does
  not
  increase
  its
  specific
  volume.
  Consequently,
  merely
  heating
  or
  cooling
  a
  control
  volume
  does
  not
  affect
  the
  air
  flow
  calculations
  in
  a
  duct
  network
  that
  may
  be
  connected
  to
  that
  volume.
  Note
  that
  multizone
  air
  exchange
  simulation
  in
  which
  buoyancy
  drives
  the
  air
  flow
  is
  still
  possible
  as
  the
  models
  in
  <a href=\"modelica://AixLib.Airflow.Multizone\">
  AixLib.Airflow.Multizone</a>
  compute
  the
  mass
  density
  using
  the
  function
  <a href=\"modelica://AixLib.Utilities.Psychrometrics.Functions.density_pTX\">
  AixLib.Utilities.Psychrometrics.Functions.density_pTX</a>
  in
  which
  density
  is
  a
  function
  of
  temperature.
</p>
<p>
  Note
  that
  models
  in
  this
  package
  implement
  the
  equation
  for
  the
  internal
  energy
  as
</p>
<p align=\"center\"
style=\"font-style:italic;\">
  u
  =
  h
  -
  p<sub>stp</sub>
  ⁄
  ρ<sub>stp</sub>,
</p>
<p>
  where
  <i>
  u</i>
  is
  the
  internal
  energy
  per
  unit
  mass,
  <i>
  h</i>
  is
  the
  enthalpy
  per
  unit
  mass,
  <i>
  p<sub>stp</sub></i>
  is
  the
  static
  pressure
  and
  <i>
  ρ<sub>stp</sub></i>
  is
  the
  mass
  density
  at
  standard
  pressure
  and
  temperature.
  The
  reason
  for
  this
  implementation
  is
  that
  in
  general,
</p>
<p align=\"center\"
style=\"font-style:italic;\">
  h
  =
  u
  +
  p
  v,
</p>
<p>
  from
  which
  follows
  that
</p>
<p align=\"center\"
style=\"font-style:italic;\">
  u
  =
  h
  -
  p
  v
  =
  h
  -
  p
  ⁄
  ρ
  =
  h
  -
  p<sub>stp</sub>
  ⁄
  ρ<sub>std</sub>,
</p>
<p>
  because
  <i>
  p
  ⁄
  ρ
  =
  p<sub>stp</sub>
  ⁄
  ρ<sub>stp</sub></i>
  in
  this
  medium
  model.
</p>
<p>
  The
  enthalpy
  is
  computed
  using
  the
  convention
  that
  <i>
  h=0</i>
  if
  <i>
  T=0</i>
  °C
  and
  no
  water
  vapor
  is
  present.
</p>
<ul>
  <li>
  November
  4,
  2016,
  by
  Michael
  Wetter:<br/>

    Set
    default
    value
    for
    <code>
    dT.start</code>
    in
    base
    properties.<br/>

    This
    is
    for
    <a href=\"https://github.com/iea-annex60/modelica-annex60/issues/575\">
    #575</a>.
  </li>
  <li>
  June
  6,
  2015,
  by
  Michael
  Wetter:<br/>

    Set
    <code>
    AbsolutePressure(start=p_default)</code>
    to
    avoid
    a
    translation
    error
    if
    <a href=\"modelica://AixLib.Fluid.Sources.Examples.TraceSubstancesFlowSource\">
    AixLib.Fluid.Sources.Examples.TraceSubstancesFlowSource</a>
    is
    translated
    in
    pedantic
    mode
    in
    Dymola
    2016.
    The
    reason
    is
    that
    pressures
    use
    <code>
    Medium.p_default</code>
    as
    start
    values,
    but
    <a href=\"modelica://Modelica.Media.Interfaces.Types\">
    Modelica.Media.Interfaces.Types</a>
    sets
    a
    default
    value
    of
    <i>
    1E-5</i>.
    A
    similar
    change
    has
    been
    done
    for
    pressure.
    This
    fixes
    <a href=\"https://github.com/iea-annex60/modelica-annex60/issues/266\">
    #266</a>.
  </li>
  <li>
  June
  5,
  2015,
  by
  Michael
  Wetter:<br/>

    Added
    <code>
    stateSelect</code>
    attribute
    in
    <code>
    BaseProperties.T</code>
    to
    allow
    correct
    use
    of
    <code>
    preferredMediumState</code>
    as
    described
    in
    <a href=\"modelica://Modelica.Media.Interfaces.PartialMedium\">
    Modelica.Media.Interfaces.PartialMedium</a>.
    Note
    that
    the
    default
    is
    <code>
    preferredMediumState=false</code>
    and
    hence
    the
    same
    states
    are
    used
    as
    were
    used
    before.
    This
    is
    for
    <a href=\"https://github.com/iea-annex60/modelica-annex60/issues/260\">
    #260</a>.
  </li>
  <li>
  May
  11,
  2015,
  by
  Michael
  Wetter:<br/>

    Removed
    <code>
    p(stateSelect=if
    preferredMediumStates
    then
    StateSelect.prefer
    else
    StateSelect.default)</code>
    in
    declaration
    of
    <code>
    BaseProperties</code>.
    Otherwise,
    when
    models
    that
    contain
    a
    fluid
    volume
    are
    exported
    as
    an
    FMU,
    their
    pressure
    would
    be
    differentiated
    with
    respect
    to
    time.
    This
    would
    require
    the
    time
    derivative
    of
    the
    inlet
    pressure,
    which
    is
    not
    available,
    causing
    the
    translation
    to
    stop
    with
    an
    error.
  </li>
  <li>
  May
  1,
  2015,
  by
  Michael
  Wetter:<br/>

    Added
    <code>
    Inline=true</code>
    for
    <a href=\"https://github.com/iea-annex60/modelica-annex60/issues/227\">
    issue
    227</a>.
  </li>
  <li>
  March
  20,
  2015,
  by
  Michael
  Wetter:<br/>

    Added
    missing
    term
    <code>
    state.p/reference_p</code>
    in
    function
    <code>
    specificEntropy</code>.
    <a href=\"https://github.com/iea-annex60/modelica-annex60/issues/193\">
    #193</a>.
  </li>
  <li>
  February
  3,
  2015,
  by
  Michael
  Wetter:<br/>

    Removed
    <code>
    stateSelect.prefer</code>
    for
    temperature.
    This
    is
    for
    <a href=\"https://github.com/iea-annex60/modelica-annex60/issues/160\">
    #160</a>.
  </li>
  <li>
  July
  24,
  2014,
  by
  Michael
  Wetter:<br/>

    Changed
    implementation
    to
    use
    <a href=\"modelica://AixLib.Utilities.Psychrometrics.Constants\">
    AixLib.Utilities.Psychrometrics.Constants</a>.
    This
    was
    done
    to
    use
    consistent
    values
    throughout
    the
    library.
  </li>
  <li>
  November
  16,
  2013,
  by
  Michael
  Wetter:<br/>

    Revised
    and
    simplified
    the
    implementation.
  </li>
  <li>
  November
  14,
  2013,
  by
  Michael
  Wetter:<br/>

    Removed
    function
    <code>
    HeatCapacityOfWater</code>
    which
    is
    neither
    needed
    nor
    implemented
    in
    the
    Modelica
    Standard
    Library.
  </li>
  <li>
  November
  13,
  2013,
  by
  Michael
  Wetter:<br/>

    Removed
    non-used
    computations
    in
    <code>
    specificEnthalpy_pTX</code>
    and
    in
    <code>
    temperature_phX</code>.
  </li>
  <li>
  March
  29,
  2013,
  by
  Michael
  Wetter:<br/>

    Added
    <code>
    final
    standardOrderComponents=true</code>
    in
    the
    <code>
    BaseProperties</code>
    declaration.
    This
    avoids
    an
    error
    when
    models
    are
    checked
    in
    Dymola
    2014
    in
    the
    pedenatic
    mode.
  </li>
  <li>
  April
  12,
  2012,
  by
  Michael
  Wetter:<br/>

    Added
    keyword
    <code>
    each</code>
    to
    <code>
    Xi(stateSelect=...</code>.
  </li>
  <li>
  April
  4,
  2012,
  by
  Michael
  Wetter:<br/>

    Added
    redeclaration
    of
    <code>
    ThermodynamicState</code>
    to
    avoid
    a
    warning
    during
    model
    check
    and
    translation.
  </li>
  <li>
  August
  3,
  2011,
  by
  Michael
  Wetter:<br/>

    Fixed
    bug
    in
    <code>
    u=h-R*T</code>,
    which
    is
    only
    valid
    for
    ideal
    gases.
    For
    this
    medium,
    the
    function
    is
    <code>
    u=h-pStd/dStp</code>.
  </li>
  <li>
  January
  27,
  2010,
  by
  Michael
  Wetter:<br/>

    Fixed
    bug
    in
    <code>
    else</code>
    branch
    of
    function
    <code>
    setState_phX</code>
    that
    lead
    to
    a
    run-time
    error
    when
    the
    constructor
    of
    this
    function
    was
    called.
  </li>
  <li>
  January
  22,
  2010,
  by
  Michael
  Wetter:<br/>

    Added
    implementation
    of
    function
    <a href=\"modelica://AixLib.Media.GasesPTDecoupled.MoistAirUnsaturated.enthalpyOfNonCondensingGas\">
    enthalpyOfNonCondensingGas</a>
    and
    its
    derivative.
  </li>
  <li>
  January
  13,
  2010,
  by
  Michael
  Wetter:<br/>

    Fixed
    implementation
    of
    derivative
    functions.
  </li>
  <li>
  August
  28,
  2008,
  by
  Michael
  Wetter:<br/>

    First
    implementation.
  </li>
</ul>

</html>"),

    Icon(graphics={

        Ellipse(

          extent={{-78,78},{-34,34}},

          lineColor={0,0,0},

          fillPattern=FillPattern.Sphere,

          fillColor={120,120,120}),

        Ellipse(

          extent={{-18,86},{26,42}},

          lineColor={0,0,0},

          fillPattern=FillPattern.Sphere,

          fillColor={120,120,120}),

        Ellipse(

          extent={{48,58},{92,14}},

          lineColor={0,0,0},

          fillPattern=FillPattern.Sphere,

          fillColor={120,120,120}),

        Ellipse(

          extent={{-22,32},{22,-12}},

          lineColor={0,0,0},

          fillPattern=FillPattern.Sphere,

          fillColor={120,120,120}),

        Ellipse(

          extent={{36,-32},{80,-76}},

          lineColor={0,0,0},

          fillPattern=FillPattern.Sphere,

          fillColor={120,120,120}),

        Ellipse(

          extent={{-36,-30},{8,-74}},

          lineColor={0,0,0},

          fillPattern=FillPattern.Sphere,

          fillColor={120,120,120}),

        Ellipse(

          extent={{-90,-6},{-46,-50}},

          lineColor={0,0,0},

          fillPattern=FillPattern.Sphere,

          fillColor={120,120,120})}));

end Air;

