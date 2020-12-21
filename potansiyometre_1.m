clear all; close all; clc;
s = serialport('COM9', 57600); flush(s);
kanal = uint8(zeros(1,4));
i = 0; % paket numarası
n = 4; % kanal sayısı
stopTime = 15; % saniye
while ( true )
    if ( read(s, 1, 'uint8') == 'h' )
        for j=1:n
            kanal(j) = read(s, 1, 'uint8');
        end
        zaman = single(read(s, 1, 'uint32') / 1e6); % time in seconds
        i = read(s, 1, 'uint16');
    end
    fprintf('Paket#%i  Kanal 1 = %i  Kanal 2 = %i  Kanal 3 = %i  Kanal 4 = %i  Zaman = %.2f\n', ...
        i, kanal(1), kanal(2), kanal(3), kanal(4), zaman);
    if (zaman > stopTime)
        break;
    end
end
delete(s);