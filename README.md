# Jarkom-Modul-3-T11-2021

Nama Anggota | NRP
------------------- | --------------		
Justin Alfonsius Sitanggang | 05311840000043
Daniel Evan | 05311940000016
Calvin Manuel | 05311940000049

## Soal 1
Luffy bersama Zoro berencana membuat peta tersebut dengan kriteria EniesLobby sebagai DNS Server, Jipangu sebagai DHCP Server, Water7 sebagai Proxy Server

### Jawaban
Berikut adalah topologi yang telah kami buat
<br> <img src="/ss/1.JPG">

## Soal 2
Foosha sebagai DHCP Relay

### Jawaban
Untuk membuat Foosha sebagai DHCP Relay kita menginstall ```isc-dhcp-relay``` tools ini berfungsi untuk menjadikan Foosha sebagai dhcp relay. Setelah menginstall kita mengonfigurasi file ```/etc/default/isc-dhcp-relay``` menjadi seperti berikut ini

```
# Defaults for isc-dhcp-relay initscript
# sourced by /etc/init.d/isc-dhcp-relay
# installed at /etc/default/isc-dhcp-relay by the maintainer scripts

#
# This is a POSIX shell fragment
#

# What servers should the DHCP relay forward requests to?
SERVERS="10.47.2.4"

# On what interfaces should the DHCP relay (dhrelay) serve DHCP requests?
INTERFACES="eth1 eth3 eth2"

# Additional options that are passed to the DHCP relay daemon?
OPTIONS=""
```
<br> <img src="/ss/2.JPG">
<br>
Servers diisikan dengan IP dari Jipangu yang merupakan DHCP Server, sedangkan untuk Interfaces, dua interface pertama merupakan interface dimana Foosha akan menerima permintaan DHCP, sedangkan interface terakhir merupakan interface dimana permintaan tersebut akan di forward (interface yang terhubung dengan Jipangu). <br>
Selanjutnya kita melakukan pengaturan di DHCP server, agar DHCP server mengerti bahwa DHCP harus di relay, dengan menambahkan pengaturan berikut pada file /etc/dhcp/dhcpd.conf

```
subnet 10.47.2.0  netmask 255.255.255.0{
}
```

<br> <img src="/ss/3.JPG">

Pada pengaturan ini, subnet diarahkan ke NID switch yang mengarah ke router Foosha, agar setiap pengaturan DHCP akan di relay ke Foosha

## Soal 3
Semua client yang ada HARUS menggunakan konfigurasi IP dari DHCP Server. Client yang melalui Switch1 mendapatkan range IP dari [prefix IP].1.20 - [prefix IP].1.99 dan [prefix IP].1.150 - [prefix IP].1.169

### Jawaban
Untuk mengatur range IP, kami menggunakan pengaturan sebagai berikut pada file /etc/dhcp/dhcpd.conf di Jipangu

```
subnet 10.47.1.0 netmask 255.255.255.0 {
    range 10.47.1.20 10.47.1.99;
    range 10.47.1.150 10.47.1.169;
    option routers 10.47.1.1;
    option broadcast-address 10.47.1.255;
    option domain-name-servers 10.47.2.2;
    default-lease-time 360;
    max-lease-time 7200;
}
```
<br> <img src="/ss/4.JPG">

Kami mengatur dua buah range yaitu 10.47.1.20 sampai 10.47.1.99 dan 10.47.1.150 dan 10.47.1.169, sedangkan untuk NID kami arahkan ke 10.47.1.0 yang merupakan IP Switch1, sehingga yang akan terpengaruh dengan konfigurasi tersebut hanyalah client yang terhubung dengan Switch1

## Soal 4
Client yang melalui Switch3 mendapatkan range IP dari [prefix IP].3.30 - [prefix IP].3.50

### Jawaban
Untuk mengatur range IP, kami menggunakan pengaturan sebagai berikut pada file /etc/dhcp/dhcpd.conf di Jipangu

```
subnet 10.47.3.0 netmask 255.255.255.0 {
    range 10.47.3.30 10.47.3.50;
    option routers 10.47.3.1;
    option broadcast-address 10.47.3.255;
    option domain-name-servers 10.47.2.2;
    default-lease-time 720;
    max-lease-time 7200;
}
```
<br> <img src="/ss/5.JPG">

Kami mengatur range yaitu 10.47.3.30 sampai 10.47.3.50, sedangkan untuk NID kami arahkan ke 10.47.3.0 yang merupakan IP Switch3, sehingga yang akan terpengaruh dengan konfigurasi tersebut hanyalah client yang terhubung dengan Switch3

## Soal 5
Client mendapatkan DNS dari EniesLobby dan client dapat terhubung dengan internet melalui DNS tersebut.

### Jawaban
Untuk mengonfigurasi kami mengarahkan option domain-name-servers ke 10.47.2.2 di file /etc/dhcp/dhcpd.conf (Jipangu) pada 2 subnet yang ada

```option domain-name-servers 10.47.2.2;```

Setelah itu pada EniesLobby sebagai DNS Server kita atur forwarders (agar bisa terhubung ke internet), comment dnssec-validation auto, dan tambahkan, allow-query{any;} pada file /etc/bind/named.conf.options, seperti berikut

```
forwarders {
         192.168.122.1;
};
        //dnssec-validation auto;
allow-query{any;};
```

<br> <img src="/ss/6.JPG">

## Soal 6
Lama waktu DHCP server meminjamkan alamat IP kepada Client yang melalui Switch1 selama 6 menit sedangkan pada client yang melalui Switch3 selama 12 menit. Dengan waktu maksimal yang dialokasikan untuk peminjaman alamat IP selama 120 menit.

### Jawaban

## Soal 7
Luffy dan Zoro berencana menjadikan Skypie sebagai server untuk jual beli kapal yang dimilikinya dengan alamat IP yang tetap dengan IP [prefix IP].3.69

### Jawaban

## Soal 8
Loguetown digunakan sebagai client Proxy agar transaksi jual beli dapat terjamin keamanannya, juga untuk mencegah kebocoran data transaksi. Pada Loguetown, proxy harus bisa diakses dengan nama jualbelikapal.yyy.com dengan port yang digunakan adalah 5000

### Jawaban

## Soal 9
Agar transaksi jual beli lebih aman dan pengguna website ada dua orang, proxy dipasang autentikasi user proxy dengan enkripsi MD5 dengan dua username, yaitu luffybelikapalyyy dengan password luffy_yyy dan zorobelikapalyyy dengan password zoro_yyy

### Jawaban

## Soal 10
Transaksi jual beli tidak dilakukan setiap hari, oleh karena itu akses internet dibatasi hanya dapat diakses setiap hari Senin-Kamis pukul 07.00-11.00 dan setiap hari Selasa-Jum’at pukul 17.00-03.00 keesokan harinya (sampai Sabtu pukul 03.00)

### Jawaban

## Soal 11
Agar transaksi bisa lebih fokus berjalan, maka dilakukan redirect website agar mudah mengingat website transaksi jual beli kapal. Setiap mengakses google.com, akan diredirect menuju super.franky.yyy.com dengan website yang sama pada soal shift modul 2. Web server super.franky.yyy.com berada pada node Skypie

### Jawaban

## Soal 12
Saatnya berlayar! Luffy dan Zoro akhirnya memutuskan untuk berlayar untuk mencari harta karun di super.franky.yyy.com. Tugas pencarian dibagi menjadi dua misi, Luffy bertugas untuk mendapatkan gambar (.png, .jpg), sedangkan Zoro mendapatkan sisanya. Karena Luffy orangnya sangat teliti untuk mencari harta karun, ketika ia berhasil mendapatkan gambar, ia mendapatkan gambar dan melihatnya dengan kecepatan 10 kbps

### Jawaban

## Soal 13
Sedangkan, Zoro yang sangat bersemangat untuk mencari harta karun, sehingga kecepatan kapal Zoro tidak dibatasi ketika sudah mendapatkan harta yang diinginkannya

### Jawaban

## Kendala
