%% RANDOM FOREST ILE INEGIN SUT VERIMLILIGI TAHMINI
clc;
clear;
close all;

% 1.Adım Önceden Oluşturulmuş Datasetimizi Yükleyelim
data = readtable('sut_verimliligi_dataset_600.csv');

% 2.Adım Eksit Değerleri Kontrol Etme ve Temizleme
if any(ismissing(data)) 
    data = rmmissing(data); %eksik verileri siler
    disp('Eksik degerler temizlendi.');
end

% 3.Adım Özellikler - X ve Hedef - Y
X = data(:, 1:end-1); %giiriş değişkenlerini alalım
Y = data.Outcome; %tahmin edilecek hedefimiz

%%4.Adım Sayısal Kontrollerimizi Yapıyoruz
if ~isnumeric(table2array(X))
    error('X degiskenleri sayisal degil.');
end

if ~isnumeric(Y)
    error('Hedef degisken Y sayisal degil.');
end

% 5.Adım (70% Eğitim - 30% Test)
rng(42); %rastgele sayı üretimini sabitleyelim
cv = cvpartition(height(data), 'HoldOut', 0.3); %verinin %30unu ayıralım bu kısmı testte kullanıcaz

XTrain = X(training(cv), :); %eğitim için tüm satırları alalım
YTrain = Y(training(cv), :); %test için seçilen hedef değerleri alır

XTest = X(test(cv), :); %modele hiç gösterilmeyen veriler
YTest = Y(test(cv), :); %>gerçek permormansı ölçmede kullanırız

% 6.Adım Model Eğitimi (BAGGING)
randomForestModel = fitcensemble(XTrain, YTrain, ...%birden fazla zayıf öğrencii birleştirir sınıf oluşturur
    'Method', 'Bag', ...
    'NumLearningCycles', 100, ... %100 adet karar ağacı oluşturuyoruz
    'Learners', templateTree('MaxNumSplits', 20)); %ağaç en fazla 20 bölünme yapacak şekilde ayarlayalım

% 7.Adım Test Verileri ile Tahmin
YPred = predict(randomForestModel, XTest); %test verisi üzerindeki sınıf tahminlerini elde ederiz

%% 8.Adım Performans Metrikleri
confMat = confusionmat(YTest, YPred);% matrixi oluşturalım

accuracy = sum(diag(confMat)) / sum(confMat, 'all'); %doğruluğu hesaplayalım

TP = confMat(2,2); %g=1 t=1
FP = confMat(1,2); %g=0 t=1
FN = confMat(2,1); %g=1 t=0

precision = TP / (TP + FP); %burada hassasiyet hesaplanır
recall    = TP / (TP + FN); %duyarlılık
f1Score   = 2 * (precision * recall) / (precision + recall); %harmonik ortalama

fprintf('Dogruluk: %.2f%%\n', accuracy*100);
fprintf('Precision: %.2f\n', precision);
fprintf('Recall: %.2f\n', recall);
fprintf('F1 Score: %.2f\n', f1Score);

% 9.Adım Yeni inek için Tahmin
newCow = table( ... %tablo oluştur.
    6, ...    % yaş
    28, ...   % günlük yem
    85, ...   % su tüketimi
    3.8, ...  % vücut sıcaklığı
    2, ...    % sağım sıklığı
    22, ...   % ortam sıcaklığı
    40, ...   % stres indeksi
    6, ...    % aktivite düzeyi
    'VariableNames', X.Properties.VariableNames); %newCow'un sütun adlarını eğitimde kullanılan X ile birebir aynı yapar.

try
    [isHighYield, score] = predict(randomForestModel, newCow); %predict ile tahmin yaparız
    if isHighYield == 1
        fprintf('Yuksek Sut Verimli (Skor: %.2f)\n', score(2));
    else
        fprintf('Dusuk Sut Verimli (Skor: %.2f)\n', score(1));
    end %sonucu yorumlayıp yazarız
catch ME
    fprintf('Hata: %s\n', ME.message); %hata ayıklama
end

%% 10.Adım Grafikler
figure;

% Egitim - Test Dagilimi
subplot(2,2,1);
counts = [sum(training(cv)), sum(test(cv))]; %veri sayısını hesaplar
bar(categorical({'Egitim Verisi','Test Verisi'}), counts);
ylabel('Veri Sayisi');
title('Egitim ve Test Veri Dagilimi');

% Confusion Matrix
subplot(2,2,2);
confusionchart(YTest, YPred);
title('Confusion Matrix');

% Performans Metrikleri
subplot(2,2,3);
bar(categorical({'Precision','Recall','F1 Score'}), ...
    [precision, recall, f1Score]);
ylim([0 1]);
ylabel('Deger');
title('Performans Metrikleri');

% ROC Egrisi
subplot(2,2,4);
[~, scores] = predict(randomForestModel, XTest);
[rocX, rocY, ~, auc] = perfcurve(YTest, scores(:,2), 1);
plot(rocX, rocY, 'LineWidth', 2);
xlabel('False Positive Rate');
ylabel('True Positive Rate');
title(['ROC Egrisi (AUC = ', num2str(auc,'%.2f'), ')']);
grid on;
