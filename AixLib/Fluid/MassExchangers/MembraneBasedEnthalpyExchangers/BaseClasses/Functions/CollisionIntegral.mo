within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.BaseClasses.Functions;
function CollisionIntegral "calculates collision integral for water in air"

  input Modelica.Units.SI.Temperature T;

  output Real Omega_D;

  constant Real kB(unit="J/K") = 1.38064852E-23 "Stefan-Boltzmann-Constant";
  constant Real epsAir = 78.6 * kB "Lennard-Jones potential of air";
  constant Real epsSteam = 363 * kB "Lennard-Jones potential of steam";

protected
  Real omegas[:];
  Real epsis[:];
  Real interp[:,2];

  Real eps12;
  Real epsInternal;
algorithm

  omegas :={2.662,2.476,2.318,2.184,2.066,1.966,1.877,1.789,1.729,1.667,1.612,1.562,
    1.517,1.476,1.439,1.406,1.375,1.346,1.320,1.296,1.273,1.253,1.233,1.215,1.198,
    1.182,1.167,1.153,1.140,1.128,1.116,1.105,1.094,1.084,1.075,1.057,1.041,1.026,
    1.012,0.9996,0.9878,0.9770,0.9672,0.9576,0.9490,0.9406,0.9328,0.9256,0.9186,
    0.9120,0.9058,0.8998,0.8942,0.8888,0.8836,0.8788,0.8740,0.8694,0.8652,0.8610,
    0.8568,0.8530,0.8492,0.8456,0.8422,0.8124,0.7896,0.7712,0.7556,0.7424,0.6640,
    0.6232,0.5960,0.5756,0.5596,0.5464,0.5352,0.5256,0.5170,0.4644,0.4360,0.4172};
  epsis :={0.3,0.35,0.4,0.45,0.5,0.55,0.6,0.65,0.7,0.75,0.8,0.85,0.9,0.95,1,1.05,1.1,1.15,1.2,1.25,1.3,1.35,
    1.4,1.45,1.5,1.55,1.6,1.65,1.7,1.75,1.8,1.85,1.9,1.95,2,2.1,2.2,2.3,2.4,2.5,2.6,2.7,2.8,2.9,3,3.1,3.2,3.3,
    3.4,3.5,3.6,3.7,3.8,3.9,4,4.1,4.2,4.3,4.4,4.5,4.6,4.7,4.8,4.9,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100,
    200,300,400};
  interp :=[epsis,omegas];

  eps12 :=(epsAir*epsSteam)^(1/2);

  epsInternal :=kB*T/eps12;

  Omega_D := AixLib.Utilities.Math.Functions.linearInterpolation(
    x=epsInternal, y_1=interp);

  annotation (Documentation(info="<html><p>
  This funtions interpolates the collision integral of a water vapour/
  air mixture for the lennard-jones potentials of air and water vapour,
  which are the inputs of the function.
</p>
<p style=\"text-align:center;\">
  <i>ε<sub>12</sub> = √(ε<sub>air</sub> ε<sub>steam</sub>)</i>
</p>
<p style=\"text-align:center;\">
  <i>Ω = f(k<sub>B</sub> T ⁄ ε<sub>12</sub>)</i>
</p>
</html>", revisions="<html>
<ul>
  <li>June 15, 2018, by Martin Kremer:<br/>
    First Implementation
  </li>
</ul>
</html>"));
end CollisionIntegral;
