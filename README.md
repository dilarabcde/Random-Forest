Bu proje, Random Forest algoritması kullanılarak ineklerin süt verimliliğinin tahmin edilmesini amaçlayan bir makine öğrenmesi uygulamasıdır. Proje MATLAB ortamında geliştirilmiş olup, çeşitli biyolojik ve çevresel veriler kullanılarak bir ineğin yüksek süt verimli ya da düşük süt verimli olup olmadığı sınıflandırılmaktadır. Sistem, tarım ve hayvancılık alanında yapay zekâ destekli karar verme süreçlerine katkı sağlamayı hedeflemektedir.

Projede kullanılan veri seti “sut_verimliligi_dataset_600.csv” dosyasından alınmıştır. Veri setinde toplam 600 kayıt bulunmaktadır. Bu kayıtlarda ineklere ait yaş, günlük yem tüketimi, su tüketimi, vücut sıcaklığı, sağım sıklığı, ortam sıcaklığı, stres indeksi ve aktivite düzeyi gibi bilgiler yer almaktadır. Hedef değişken olarak ise “Outcome” sütunu kullanılmıştır. Outcome değeri 1 olduğunda yüksek süt verimi, 0 olduğunda ise düşük süt verimi anlamına gelmektedir.

İlk aşamada veri seti MATLAB ortamına aktarılmış ve eksik veriler kontrol edilmiştir. Eğer eksik değer bulunursa bu veriler sistemden temizlenmiştir. Daha sonra giriş değişkenleri (X) ve hedef değişken (Y) birbirinden ayrılmıştır. Modelin doğru çalışabilmesi için tüm verilerin sayısal formatta olup olmadığı kontrol edilmiştir.

Veri seti eğitim ve test olmak üzere ikiye ayrılmıştır. Verilerin %70’i model eğitimi için, %30’u ise test işlemleri için kullanılmıştır. Rastgelelik işlemlerinin her çalıştırmada aynı sonucu vermesi amacıyla “rng(42)” komutu kullanılmıştır.

Makine öğrenmesi modeli olarak Random Forest yöntemi tercih edilmiştir. MATLAB içerisinde “fitcensemble” fonksiyonu kullanılarak Bagging yöntemiyle birden fazla karar ağacı oluşturulmuştur. Model içerisinde toplam 100 adet karar ağacı kullanılmış ve her ağacın maksimum 20 bölünme yapmasına izin verilmiştir. Bu yapı sayesinde modelin daha kararlı ve daha doğru tahminler yapması sağlanmıştır.

Model eğitildikten sonra test verileri üzerinde tahmin işlemleri gerçekleştirilmiştir. Elde edilen sonuçlar ile gerçek sonuçlar karşılaştırılarak performans analizi yapılmıştır. Performans değerlendirmesinde doğruluk (accuracy), precision, recall ve F1 score metrikleri kullanılmıştır. Ayrıca confusion matrix oluşturularak modelin hangi sınıfları ne kadar doğru tahmin ettiği görselleştirilmiştir. ROC eğrisi ve AUC değeri kullanılarak modelin sınıflandırma başarısı detaylı şekilde analiz edilmiştir.

Projede ayrıca yeni bir inek için tahmin işlemi de yapılabilmektedir. Kullanıcı tarafından yaş, yem tüketimi, su tüketimi, vücut sıcaklığı gibi bilgiler girildiğinde sistem bu verileri kullanarak ineğin süt verimliliğini tahmin etmektedir. Eğer model sonucu 1 olarak tahmin ederse yüksek süt verimli, 0 olarak tahmin ederse düşük süt verimli sonucu ekrana yazdırılmaktadır.

Sistem sonunda eğitim-test veri dağılımı, confusion matrix, performans metrikleri ve ROC eğrisi gibi çeşitli grafikler oluşturulmaktadır. Bu grafikler modelin başarısını görsel olarak değerlendirmeyi sağlamaktadır.

Bu proje sayesinde yapay zekâ ve makine öğrenmesi tekniklerinin hayvancılık sektöründe nasıl kullanılabileceği gösterilmiştir. Gelecekte projeye gerçek zamanlı sensör verileri eklenerek daha gelişmiş tahmin sistemleri geliştirilebilir. Ayrıca web tabanlı veya mobil destekli bir arayüz oluşturularak sistemin kullanıcı dostu hale getirilmesi mümkündür.
