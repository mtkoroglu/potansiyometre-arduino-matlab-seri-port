clear all; close all; clc;
s = serialport('COM7', 57600); flush(s);
kanal = uint8(zeros(1,4));
i = 0; % paket numarası
n = 4; % kanal sayısı
stopTime = 15; % saniye
tic;
while ( true )
    zaman = toc;
    if ( read(s, 1, 'uint8') == 'h' )
        i = i + 1; % paket alınıyor
        for j=1:n
            kanal(i) = read(s, 1, 'uint8');
        end
    end
    fprintf('Paket#1 = %i  Kanal 1 = %i  Kanal 2 = %.i  Kanal 3 = %i  Kanal 4 = %i  Zaman = %.2f\n', ...
        i, kanal(1), kanal(2), kanal(3), kanal(4), zaman);
    if (zaman > stopTime)
        break;
    end
end
delete(s);
