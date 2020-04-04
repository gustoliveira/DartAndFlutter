## O QUE FOI ESTUDADO NESTE APP

Navegação (Navigator) simples:
1. Criar um diretório com as interfaces
2. Criar uma classe (stateful ou stateless) que contenha a ui
3. Importar a interface que vai ser chamada na interface que chama
4. Chamar a função _Navigator.push_, que recebe o _context_ e a outra função _MaterialPageRouter_ (a rota para a outra página), neste última voce vai passar um _builder_ que o context e que retorna a classe da ui

GridView:
* Organiza widgets em um grid (rede)
* Widget SliverGridDelegateWithFixedCrossAxisCount (Pode configurar quantos widgets vão ser dispostos e o espaçamento)

Compartilhar arquivos:
* Utilização da biblioteca 'package:share/share.dart'
* Permite fazer o share de arquivos por outras plataformas, como WhatsApp, Twitter, email, etc

Widget GestureDetector:
* Widget que percebe que está sendo clicado e assim pode fazer alguma ação
* pode fazer açoes diferentes no onTap() e onLongPress()

Circulo de progresso de carregamento quando se abre o aplicativo ou volta a home

Aparecer widget (no caso deste aplicativo, uma imagem) em Fade:
* uso de 'package:transparent_image/transparent_image.dart'
