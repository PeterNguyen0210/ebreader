import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:ebook_reader/model/book.dart';

class BookViewer extends StatefulWidget {
  final Book book;
  BookViewer({Key key, @required this.book}) : super(key: key);

  @override
  BookViewerState createState() => new BookViewerState();
}

class BookViewerState extends State<BookViewer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (context, position) {
          return Html(
            padding: EdgeInsets.all(6),
            data: """
    <div>
      <div id="header_set">
      <h1>Header 1</h1>
      <h2>Header 2</h2>
      <h3>Header 3</h3>
      <h4>Header 4</h4>
      <h5>Header 5</h5>
      <h6>Header 6</h6>
      <hr />
      Below hr
      <b>Bold</b>
      </div>
      <h1>Demo Page</h1>
      <p>This is a <u>fantastic</u> nonexistent product that you should really really really consider buying!</p>
      <br />
      <h2>Pricing</h2>
      <p>Lorem ipsum <b>dolor</b> sit amet.</p>
      <center>
        This is some center text... <abbr>ABBR</abbr> and <acronym>ACRONYM</acronym>
      </center>
      <h2>The Team</h2>
      <p>There isn't <i>really</i> a team...</p>
      <h2>Installation</h2>
      <p>You <u>cannot</u> install a nonexistent product!</p>
      <h2>Don't ask me to find <em>x</em> in</h2>
      <p>log<sub>2</sub>(<em>x</em><sup>2</sup> - 6<em>x</em>) = 3 + log<sub>2</sub>(1 - <em>x</em>)</p>
      <div id="bdi_test">
        <h3><code>bdi</code> and <code>bdo</code> Test:</h3>
        <p>
        In the example below, usernames are shown along with the number of points in a contest.
        If the bdi element is not supported in the browser, the username of the Arabic user would confuse the text (the bidirectional algorithm would put the colon and the number "90" next to the word "User" rather than next to the word "points").
        </p>
        
        <ul>
         <li>User <bdi>hrefs</bdi>: 60 points</li>
         <li>User <bdi>jdoe</bdi>: 80 points</li>
         <li>User <bdi>إيان</bdi>: 90 points</li>
         <bdo dir="rtl">Swapped!</bdo>
         <bdo dir="ltr">This text will go left to right!</bdo>
         <bdo dir="rtl">With bdi: User <bdi>إيان</bdi>: 90 points</bdo>
         <bdo dir="rtl">Without bdi: User إيان: 90 points</bdo>
         <bdo dir="ltr">ltr w/ bdi: User <bdi>إيان</bdi>: 90 points</bdo>
         <bdo dir="ltr">ltr w/o bdi: User إيان: 90 points</bdo>
        </ul>
      </div>
            <div>
              <table>
              <caption>This is the table's caption</caption>
                <tr><th>Head 1<sup>*</sup></th><th>Head 2</th><th>Head 3</th></tr>
                <tr><td>Data 1</td><td>Long Data 2</td><td>Really, realllllly, long data 3</td></tr>
                <tr><td>Data 1</td><td>Long <b>Data</b> 2</td><td>Really, realllllly, long data 3</td></tr>
                <tr><td>Data 1</td><td>Long Data 2</td><td>Really, realllllly, long data 3</td></tr>
                <tr><td>Different 1</td><td>Different reallllllly long 2</td><td>Diff 3</td></tr>
                <tr><td colspan="2">This spans 2 columns</td><td>Normal td</td></tr>
                <tfoot>
                <tr><td>In foot 1</td><td>In foot 2</td><td>In foot long 2</td></tr>
                </tfoot>
              </table>
            </div>
            <div>Nested div</div>
            <div>
            <pre>
            jQuery("#monkey");
            </pre>
            <br />
            <p><q>This is a fancy quote</q></p>
            <br />
            <br />
            Second nested div<br />
            <figure>
            <figcaption>Available on GitHub</figcaption>
            </figure>
            </div>
            <div>Third nested div</div>
          </div>
          <h1>Second header</h1>
          <h1>Third header</h1>
          <div>Fourth div</div>
          <custom_tag>dasdasdasdasd</custom_tag>
  """,
          );
        },
      ),
    );
  }
}
