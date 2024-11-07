# d2webreport
Este repositório contém um conjunto de classes Delphi desenvolvido para gerar relatorios no formato HTML Criado para um projeto em [D2Bridge](https://www.d2bridge.com.br/), um framework que permite compilar projetos VCL ou FireMonkey para a Web com o mesmo código.

<p align="center">
	<img src="https://agiliza.click/charts.gif">
</p>


## Instalação
Instalação usando o boss
```
boss install https://github.com/JoRodriguesDev/d2webreport
```

## Declaração
Para utilizar o d2webreport você deve adicionar as uses:
```pascal
  uModel.Report.Interfaces,
  uModel.Report.Factory;
```

## Como usar
```pascal
  var HTML := TModelReportFactory.New
								 .HTMLReport
								 .HeaderColor($157347, $FFFFFF)
								 .BackgroundColor($e8f0ff)
									.Titulo('Relatorio de Titulares')
									.AddReportDataSet(['Código', 'Nome', 'CPF', 'Situação'])
										.AddReportData([1, 'Antonio Jorge Ruan das Neves', '775.304.570-98', 'Ativo'])
										.&End
									.Generate;
```
