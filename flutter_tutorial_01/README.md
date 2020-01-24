# __Building layouts__

Um resumo do manual de construção de layouts com Flutter e Dart com dicas e seus códigos.

<p align="center">
    <img src="https://flutter.dev/assets/ui/layout/lakes-2e8707102ca4f56f44e40ce3703606e1600ac1574fe5544c0f2d96f966bed853.jpg" height="400">
</p>


### __IDENTIFICANDO OS ELEMENTOS MAIS ABRANGENTES__
<p align="center">
    <img src="https://flutter.dev/assets/ui/layout/lakes-column-elts-b1f1ec8c2cc0cc667f3935dd665a27b2d15171c8466dc5b893e98b88b265414c.png" height="400">
</p>

Quatro elementos em arranjados em _uma coluna_:
* Uma imagem
* Linha: Title Section
* Linha: Button Section
* Bloco de texto

#### Title Section
<p align="center">
    <img src="https://flutter.dev/assets/ui/layout/title-section-parts-91480d296e122c9cf2994439b82da0c43df795c1085ec6efb9a916da371248c5.png" height="125">
</p>

Essa linha possui _três filhos_:
* Coluna de texto contendo duas linhas
* Ícone de estrela
* Um número

#### Button Section
<p align="center">
    <img src="https://flutter.dev/assets/ui/layout/button-section-diagram-3dac85a884b67876ce7b39e4f0bd43b93886c8f61d25055ad2d0971adb16907c.png" height="125">
</p>

Também contém _três filhos_:
* Cada um deles é uma _coluna_ que contém _um ícone e um texto_

__Após dividir exatamente como será o layout, fica mais fácil de implementar, pois causará uma confusão visual menor ao já saber exatamente o que se fazer.__

### __IMPLEMENTANDO _TITLE SECTION___

```{Flutter}
Widget titleSection = Container(
  padding: const EdgeInsets.all(32), /*4*/
  child: Row(
    children: [
      Expanded(
        /*1*/
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*2*/
            Container(
              padding: const EdgeInsets.only(bottom: 8), /*5*/
              child: Text(
                'Oeschinen Lake Campground',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Kandersteg, Switzerland',
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
      /*3*/
      Icon(
        Icons.star,
        color: Colors.red[500],
      ),
      Text('41'),
    ],
  ),
);
```
* __/\*1\*/:__ Colocar a coluna dentro de um _Exapanded Widget_ fará ele ocupar mais espaço, jogando os outros ícones para o lado mais a direita. _crossAxisAlignment: CrossAxisAlignment_ fará com que a coluna comece à esquerda, no começo da linha.

* __/\*2\*/__: Colocar o texto de um _Container_ possibilita adicionar _padding_ (preenchimento_). O segunto texto da linha está em cinza.

* __/\*3\*/__: Os útimos item são o ícone de estrela em vermelho e um texto contendo um número '41'.

* __/\*4\*/__: _padding: const EdgeInsets.all(32)_ serve para preencher a linha com 32 pixels. Ou seja, cria uma especie de margem de 32 pixels por todos os lados. Assim como em __/\*5\*/__, que está adicionando uma margem de 8 pixels apenas na base.


### __IMPLEMENTANDO _BUTTON SECTION___

Como essa linha é dividida em três filhos praticamente iguais, é melhor criar um método privado que ajude a criar-los.

```{Flutter}
Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
```

Trata-se de um método que _retorna uma coluna_ e _recebe como paramentros a cor, o icone e o texto que vai em baixo_.

Após isso, é só criar o Widget contendo um container e dentro dele chamar o método anterior para construir os filhos.

```{Flutter}
Color color = Theme.of(context).primaryColor;

Widget buttonSection = Container(
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly, /*1*/
    children: [
      _buildButtonColumn(color, Icons.call, 'CALL'),
      _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
      _buildButtonColumn(color, Icons.share, 'SHARE'),
    ],
  ),
);
```

* __/\*1\*/__: Coloca um espaço igual entre cada um dos filhos

### __IMPLEMENTANDO _TEXT SECTION___
Defina o textSection como uma variável que recebe o retorno de um Container, colocando o texto e um _padding_ de todos os lados.

```{Flutter}
Widget textSection = Container(
  padding: const EdgeInsets.all(32),
  child: Text(
    'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
        'Alps. Situated 1,578 meters above sea level, it is one of the '
        'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
        'half-hour walk through pastures and pine forest, leads you to the '
        'lake, which warms to 20 degrees Celsius in the summer. Activities '
        'enjoyed here include rowing, and riding the summer toboggan run.',
    softWrap: true,
  ),
);
```

### __IMPLEMENTANDO _IMAGE SECTION___

Crie um diretório chamado _images_ e adiciona a imagem.

Atualize o pubsec.yaml e inclua a imagem nos _assets_:

```{Flutter}
flutter:
    uses-material-design: true
    assets:
      - images/lake.jpg
```

Adicione a imagem no seção _body_ do _build_

```{FLutter}
body: ListView( /*1*/
	children: [
		Image.asset(
			'images/lake.jpg',
			width: 600,
			height: 240,
			fit: BoxFit.cover, /*2*/
		),
		titleSection,
		buttonSection,
		textSection,
```
* __/\*1\*/__: _ListView_ neste caso é melhor que _Columm_ pois irá possibilitar o scroll em celular com tela menor.
* __/\*2\*/__: _BoxFit.cover_ fala para o framework colocar a imagem o menor possível mas ainda que possa ocupar toda a caixa definida no tamanho.

## __DEFINIÇÕES__:

* _Columns e Rows_: Servem para especificar como os filhos vão ser alinhados.

* _Container_ é uma classe de widget que permite personalizar seu widget filho. Usa-se para adicionar preenchimento (_padding_), margens, bordas ou cor de fundo para nomear alguns de seus recursos. É uma classe mais generalista.

* _padding_ adicionar algum espaço extra ao redor de um widget.

* _margin_ trata-se de um atributo do _Container_ que cria um espaço vazio entre a _decoration_ (pintura atrás dos filhos) e os filhos

* _EdgeInsets_ é usado para especificar a quantidade de preenchimento extra, podendo ser _all_(todos os lados), ou _only_(left, right, top, bottom).





## __FONTES__:

[Documentação Oficial do Flutter](https://flutter.dev/docs/development/ui/layout/tutorial)

[Layouts no Flutter por José Carlos Macoratti](http://www.macoratti.net/19/07/flut_layout1.htm)