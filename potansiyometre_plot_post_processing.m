clear all; close all; clc;
s = serialport('COM9', 57600); flush(s);
% kanal = uint8(zeros(1,4));
i = 0; % paket numarası
n = 4; % kanal sayısı
stopTime = 15; % saniye
tic;
while ( true )
    if ( read(s, 1, 'uint8') == 'h' )
        i = i + 1; % paket alınıyor
        zaman(i) = toc;
        for j=1:n
            kanal(j,i) = read(s, 1, 'uint8');
        end
    end
    fprintf('Paket#%i  Kanal 1 = %i  Kanal 2 = %i  Kanal 3 = %i  Kanal 4 = %i  Zaman = %.2f\n', ...
        i, kanal(1,i), kanal(2,i), kanal(3,i), kanal(4,i), zaman(i));
    if (zaman(i) > stopTime)
        break;
    end
end
delete(s);