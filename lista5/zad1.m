%zadanie 1
dt = 0.1;
sysc = tf([1], [1, 3, 2]);
sysd = c2d(sysc, dt);

[y1, t1] = step(sysc);
[y2, t2] = step(sysd);

plot(t1,y1, "red");
hold;
stairs(t2,y2, "blue")
