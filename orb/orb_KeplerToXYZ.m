function rv = orb_KeplerToXYZ (a, e, i, OMEGA, u, MU)
% ������� ���������� ��������� ������ � ���������� ��������������� �������
% ���������
%
% ������� ������: 
% ����� ��������� ������, ������������ ��������� �� �� ������:
% a        - ������� �������          [��],
% e        - ��������������,
% i        - ����������               [���],
% $\Omega$ - ������� ����������� ���� [���],
% u        - �������� ��������        [���].
% MU       - �������������� �������� ������� [��^3/�^2], ��� ����� = 398600.435608.
%
% �������� ������:
% rv(6) = [rx; ry; rz, Vx; Vy; Vz] - ������-������ ��������� �� �� ������
% [��] � ������ �������� �� [��/�].
%
% Example:
%
% >> orb_KeplerToXYZ(6378 + 122, 0.0, 0.0, 0.0, 0.0, 398600.435608)
% 
% ans =
% 
%                       6500
%                          0
%                          0
%                          0
%            7.8309095218686
%                          0

cos_u     = cos(u); 
sin_u     = sin(u);
cos_i     = cos(i);
sin_i     = sin(i);
cos_OMEGA = cos(OMEGA);
sin_OMEGA = sin(OMEGA);

p              = a*(1 - e*e);	     % ��������� ��������, [��]
r              = p/(1 + e*cos_u);    % ���������� �� ��, [��]
V_radial       = sqrt(MU/p)*e*sin_u; % ���������� ��������, [��/c]
V_angular_rate = sqrt(MU*p)/r^2;     % ������� ��������, [���/�]
    
% q = V_radial/r_orb;
% s = V_angular_rate*r_orb;
    
rx = r * (cos_u*cos_OMEGA - sin_u*sin_OMEGA*cos_i);
ry = r * (cos_u*sin_OMEGA + sin_u*sin_OMEGA*cos_i);
% ry = r * (cos_u*sin_OMEGA + sin_u*cos_OMEGA*cos_i);
rz = r * (sin_u*sin_i);

Vx = (V_radial/r) * rx + (V_angular_rate*r) * (- sin_u*cos_OMEGA - cos_u*sin_OMEGA*cos_i);
Vy = (V_radial/r) * ry + (V_angular_rate*r) * (- sin_u*sin_OMEGA + cos_u*cos_OMEGA*cos_i);
Vz = (V_radial/r) * rz + (V_angular_rate*r) * cos_u*sin_i;

rv = [rx; ry; rz; Vx; Vy; Vz];

end