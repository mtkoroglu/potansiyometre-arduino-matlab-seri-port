clear all; close all; clc;
% baudrate'i artırmayı dene
s = serialport('COM9', 57600); flush(s); % clean the buffer
n = 4; % kanal sayısı
kanal = uint8(zeros(1,n));
i = 0; % paket
realTimeDisplay = false; realTimePlot = true;
zamanPenceresi = 20;
downSamplingRate = 10; sampleNumber = 0; % for real-time plotting
%% Kullanıcı tarafından durdurulacak bir döngüyü ayarlıyoruz
ButtonHandle = uicontrol('Style', 'PushButton', ...
                         'String', 'Stop loop', ...
                         'Callback', 'delete(gcbf)');
figure(1);
hold on; grid on; ax = gca; ax.GridLineStyle = '--';
xlabel('zaman (s)'); ylabel('kanal sinyali');
%%
tic; % start the timer
while ( true )
    zaman = toc;
    if (sampleNumber == downSamplingRate)
        sampleNumber = 0;
    end
    if ( read(s, 1, 'uint8') == 'h' )
        i = i + 1; % paket alınıyor
        for j=1:n
            kanal(j) = read(s, 1, 'uint8');
        end
    end
    if (realTimeDisplay)
        fprintf('Paket#%i  Ch1 = %i  Ch2 = %.i  Ch3 = %i  Ch4 = %i  zaman = %.2f  Bytes on the buffer %i\n', ...
            i, kanal(1), kanal(2), kanal(3), kanal(4), zaman, s.NumBytesAvailable);
    end
    if ( realTimePlot && sampleNumber == 0 )
        plot(zaman, kanal(1), 'r.'); % kanal 1 sinyalini kırmızı ile çizdir
        plot(zaman, kanal(2), 'b.'); % kanal 2 sinyalini mavi ile çizdir
        plot(zaman, kanal(3), 'g.'); % kanal 3 sinyalini yeşil ile çizdir
        plot(zaman, kanal(4), 'k.'); % kanal 4 sinyalini siyah ile çizdir
        legend(sprintf('Kanal 1 = %i', kanal(1)), sprintf('Kanal 2 = %i', kanal(2)), ...
            sprintf('Kanal 3 = %i', kanal(3)), sprintf('Kanal 4 = %i', kanal(4)));
        title(sprintf('Paket no: %i    Zaman = %.2f', i, zaman));
        tempBounds = floor(zaman/zamanPenceresi);
        axis([tempBounds*zamanPenceresi, (tempBounds+1)*zamanPenceresi, -10, 345]);
    end
    if ~ishandle(ButtonHandle)
        disp('4 kanallı radyo alıcı-verici programı kullanıcı tarafından sonlandırıldı.');
        break;
    end
    sampleNumber = sampleNumber + 1;
end
delete(s);