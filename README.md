# CSV Adapter for RESTRequest4Delphi

This is the adapter for generating CSV files for [RESTRequest4Delphi](https://github.com/viniciussanchez/RESTRequest4Delphi). Allows you to generate a text or CSV file with the content of a request.



## 📞 Contacts

<p align="left">
  <a href="https://t.me/Code4Delphi" target="_blank">
    <img src="https://img.shields.io/badge/Telegram:-Join%20Channel-blue?logo=telegram">
  </a>  
  &nbsp;
  <a href="https://code4delphi.com.br/blog" target="_blank">
    <img src="https://img.shields.io/badge/Blog:-Access-731211?logo=readdotcv&logoColor=731211">
  </a> 
  &nbsp;
  <a href="https://www.youtube.com/@code4delphi" target="_blank">
    <img src="https://img.shields.io/badge/YouTube:-Join%20Channel-red?logo=youtube&logoColor=red">
  </a> 
  &nbsp;
  <a href="mailto:contato@code4delphi.com.br" target="_blank">
    <img src="https://img.shields.io/badge/E--mail-contato%40code4delphi.com.br-yellowgreen?logo=maildotru&logoColor=yellowgreen">
  </a>
</p>


## ✳ Prerequisites
This adapter must be used together with [RESTRequest4Delphi](https://github.com/viniciussanchez/RESTRequest4Delphi)


## ⚙️ Installation

* Installation using the [**Boss**](https://github.com/HashLoad/boss):

``` sh
boss install github.com/Code4Delphi/csv-adapter-restrequest4delphi
```

* **Manual installation**: Open your Delphi and add the following folder to your project, under *Project > Options > Building > Delphi Compiler > Search path*

```
csv-adapter-restrequest4delphi\Src
```



## 🚀 Quickstart
* Add uses to your system:
```delphi
uses
  CSV.Adapter.RESTRequest4D;
```

* Getting the CSV for a TString:  
```delphi
begin
  TRequest.New.BaseURL('http://localhost:9050/clients')
    .Adapters(TCSVAdapterRESTRequest4D.New(Memo1.Lines, 'optional-root-element'))
    .Accept('application/json')
    .Get;
end;
```

* Automatically saving CSV to a file:  
```delphi
begin
  TRequest.New.BaseURL('http://localhost:9050/clients')
    .Adapters(TCSVAdapterRESTRequest4D.New('C:\Temp\MyFile.csv', 'optional-root-element'))
    .Accept('application/json')
    .Get;
end;
```

## ⚙ Configurations
You can customize some features of CSV Adapter for RESTRequest4Delphi:
* Separator (the default is ; (semicolon))
```delphi
TCSVAdapterRESTRequest4D.Config.Separator(';');
```


## ⌨️ Demo
* Along with the project sources, you will find test projects. The API and Client project are respectively in the folders:
```
csv-adapter-restrequest4delphi\Samples\API
csv-adapter-restrequest4delphi\Client
```
![image](https://github.com/user-attachments/assets/ba99d0c6-da6f-4609-9ac3-40490dd7de1c)



‌
# 💬 Contributions / Ideas / Bug Fixes
To submit a pull request, follow these steps:

1. Fork the project
2. Create a new branch (`git checkout -b minha-nova-funcionalidade`)
3. Make your changes
4. Make the commit (`git commit -am 'Functionality or adjustment message'`)
5. Push the branch (`git push origin Message about functionality or adjustment`)
6. Open a pull request
