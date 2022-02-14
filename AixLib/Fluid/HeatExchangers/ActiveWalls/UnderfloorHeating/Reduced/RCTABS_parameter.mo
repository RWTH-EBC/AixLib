within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Reduced;
function RCTABS_parameter
    // Resistors calculation
  import Modelica.Constants.pi;
  input Modelica.SIunits.Time t_bt = 7*86400;
  input AixLib.DataBase.Walls.WallBaseDataDefinition TABSlayers
    "Upper TABS layers"    annotation (Dialog(group="Room Specifications"), choicesAllMatching=true);
  input Modelica.SIunits.Area area;
  output Real param[3] = zeros(3);
protected
  Real omega = 2*pi/t_bt;
  Integer n_up = TABSlayers.n;
  Real r_up[n_up] = TABSlayers.d ./ (TABSlayers.lambda);
  Real c_up[n_up] = TABSlayers.d .* TABSlayers.c .* TABSlayers.rho;
  Real re11[n_up] = cosh(sqrt(0.5 .* omega .* r_up .* c_up)) .* cos(sqrt(0.5 .* omega .* r_up .* c_up));
  Real im11[n_up] = sinh(sqrt(0.5 .* omega .* r_up .* c_up)) .* sin(sqrt(0.5 .* omega .* r_up .* c_up));
  Real re12[n_up] = r_up .* sqrt(1 ./ (2 .* omega .* r_up .* c_up)) .* (cosh(sqrt(0.5 .* omega .* r_up .* c_up)) .* sin(sqrt(0.5 .* omega .* r_up .* c_up)) .+
                sinh(sqrt(0.5 .* omega .* r_up .* c_up)) .* cos(sqrt(0.5 .* omega .* r_up .* c_up)));
  Real im12[n_up] = r_up .* sqrt(1 ./ (2 .* omega .* r_up .* c_up)) .* (cosh(sqrt(0.5 .* omega .* r_up .* c_up)) .* sin(sqrt(0.5 .* omega .* r_up .* c_up)) .-
                sinh(sqrt(0.5 .* omega .* r_up .* c_up)) .* cos(sqrt(0.5 .* omega .* r_up .* c_up)));
  Real re21[n_up] = (-1 ./ r_up) .* (sqrt(0.5 .* omega .* r_up .* c_up)) .* (cosh(sqrt(0.5 .* omega .* r_up .* c_up)) .*
                sin(sqrt(0.5 .* omega .* r_up .* c_up)) .- sinh(sqrt(0.5 .* omega .* r_up .* c_up)) .* cos(sqrt(0.5 .* omega .* r_up .* c_up)));
  Real im21[n_up] = (1 ./ r_up) .* (sqrt(0.5 .* omega .* r_up .* c_up)) .* (cosh(sqrt(0.5 .* omega .* r_up .* c_up)) .*
                sin(sqrt(0.5 .* omega .* r_up .* c_up)) .+ sinh(sqrt(0.5 .* omega .* r_up .* c_up)) .* cos(sqrt(0.5 .* omega .* r_up .* c_up)));
  Real re22[n_up] = re11;
  Real im22[n_up] = im11;
  Real a_layer_up[n_up,4,4] = zeros(n_up,4,4);
  Real new_mat[4,4] = identity(4);
  Real r1;
  Real c1_korr;
  Real r2;
  Real r3;
  Real r_wall;
algorithm
    for i in 1:n_up loop
      a_layer_up[i,1,1]:=re11[i];
      a_layer_up[i,1,2]:=im11[i];
      a_layer_up[i,1,3]:=re12[i];
      a_layer_up[i,1,4]:=im12[i];
      a_layer_up[i,2,1]:=-im11[i];
      a_layer_up[i,2,2]:=re11[i];
      a_layer_up[i,2,3]:=-im12[i];
      a_layer_up[i,2,4]:=re12[i];
      a_layer_up[i,3,1]:=re21[i];
      a_layer_up[i,3,2]:=im21[i];
      a_layer_up[i,3,3]:=re22[i];
      a_layer_up[i,3,4]:=im22[i];
      a_layer_up[i,4,1]:=-im21[i];
      a_layer_up[i,4,2]:=re21[i];
      a_layer_up[i,4,3]:=-im22[i];
      a_layer_up[i,4,4]:=re22[i];
    end for;
   for i in 1:n_up loop
     new_mat := new_mat*a_layer_up[i];
   end for;
   r1 :=(1/area)*((new_mat[4, 4] - 1)*new_mat[1, 3] + new_mat[3, 4] * new_mat[1, 4])
    /((new_mat[4, 4] - 1)^2 + new_mat[3, 4]^2);
   r2 :=(1/area)*((new_mat[1, 1] - 1)*new_mat[1, 3] + new_mat[1, 2] * new_mat[1, 4])
    /((new_mat[1, 1] - 1)^2 + new_mat[1, 2]^2);
   r3 :=(1/area)*(sum(r_up)) - r1 - r2;
   r_wall := r1 + r2 + r3;
   c1_korr := (1 / (omega * r1)) * ((r_wall * area - new_mat[1,3] * new_mat[4,4]
    - new_mat[1,4] * new_mat[3,4]) / (new_mat[4,4] * new_mat[1,4] - new_mat[1,3] * new_mat[3,4]));
   param[1] :=r1;
   param[2] :=c1_korr;
   param[3] :=(1/area)*(sum(r_up)) - r1;


end RCTABS_parameter;
