dt = 0.1;
sysc = tf([1], [1, 3, 3, 1]);
sysd = c2d(sysc, dt);


 kp = 2;
 ki = 2;
% 
% syscPI = tf([kp, ki], [1]);
% sysdPI = c2d(syscPI, dt);


[num, dend] = tfdata(sysd, 'v');


sim('schemat.slx');