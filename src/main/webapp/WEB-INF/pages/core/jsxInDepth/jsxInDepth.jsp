<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="lt" tagdir="/WEB-INF/tags/layout" %>
<%@taglib prefix="wg" tagdir="/WEB-INF/tags/widget" %>
<%@taglib prefix="ce" tagdir="/WEB-INF/tags/application/core/jsx-in-depth" %>
<%@taglib prefix="app" tagdir="/WEB-INF/tags/application" %>

<c:url var="granularDomUpdatesUrl" value="/resources/imges/pages/basics/render-elements/granular-dom-updates.gif"/>
<c:url var="babelJsxUrl" value="https://babeljs.io/repl/#?presets=react&code_lz=GYVwdgxgLglg9mABACwKYBt1wBQEpEDeAUIogE6pQhlIA8AJjAG4B8AEhlogO5xnr0AhLQD0jVgG4iAXyJA"/>

<a name="pageStart"></a>
<lt:layout cssClass="black-line"/>
<lt:layout cssClass="page hello-world-example-page">
	<h1>3.1 JSX изнутри</h1>

	<wg:p>По существу, JSX просто предоставляет синтаксический сахар для функции
		<code>React.createElement(component, props, ...children)</code>. JSX-код:</wg:p>

	<ce:code-example-1/>

	<wg:p>компилируется в:</wg:p>

	<ce:code-example-2/>

	<wg:p>Вы также можете использовать самозакрывающуюся форму тегов, если у них нет потомков:</wg:p>

	<ce:code-example-3/>

	<wg:p>компилируется в:</wg:p>

	<ce:code-example-4/>

	<wg:p>Если вам нужно проверить как указанный вами JSX конвертируется в JS,
		вы можете попробовать <wg:link href="${babelJsxUrl}">компилятор Babel онлайн</wg:link>.</wg:p>

	<br/>
	<h2>3.1.1 Указание типа React-элемента</h2>

	<wg:p>Первая часть JSX-тега определяет тип React-элемента. Типы записываются с
		большой буквы и указывают, что JSX-тег ссылается на React-компонент. Эти теги
		компилируются в прямые ссылки на именованные переменные. Поэтому если вы используете
		выражение <code>&lt;MyComponent /&gt;</code>, <code>MyComponent</code> должен находиться в области видимости.</wg:p>

	<br/>
	<h3>3.1.1.1 React должен находиться в области видимости</h3>

	<wg:p>После того, как JSX скомпилируется в вызовы <code>React.createElement</code>,  библиотека
		React также должна всегда быть в области видимости вашего JSX-кода.</wg:p>

	<wg:p>Например, оба импорта необходимы в данном коде, даже если на <code>React</code> и
		<code>Message</code> нет прямых ссылок из JavaScript:</wg:p>

	<ce:code-example-5/>

	<wg:p>Если вы не используете JavaScript сборщик и подгружаете React
		из <code>&lt;script&gt;</code> тега, то он уже находится в области видимости как глобальный <code>React</code> объект.</wg:p>

	<br/>
	<h3>3.1.1.2 Использование записи через точку "." в JSX</h3>

	<wg:p>Вы также можете ссылаться на React-компонент используя запись через точку внутри JSX.
		Это удобно, если у вас есть единственный модуль, который экспортирует несколько React-компонентов.
		К примеру, если <code>MyComponents.Button</code> – это компонент, вы можете обратиться к
		нему напрямую в JSX, используя точку:</wg:p>

	<ce:code-example-6/>

	<br/>
	<h3>3.1.1.3 Названия пользовательских компонентов должны начинаться с большой буквы</h3>

	<wg:p>Когда название типа элемента начинается с маленькой буквы, он ссылается на встроенный компонент,
		такой как <code>&lt;div&gt;</code> или <code>&lt;span&gt;</code>, обуславливая передачу
		строк “<code>div</code>” или “<code>span</code>” в вызов <code>React.createElement</code>.</wg:p>

	<wg:p>Названия типов, которые начинаются с большой буквы, такие как <code>&lt;MyComponent/&gt;</code> компонент,
		компилируется в <code>React.createElement(MyComponent)</code> и соответствует компоненту, определенному
		или импортированному в ваш JavaScript файл.</wg:p>

	<wg:p>Рекомендуется именовать компоненты с большой буквы. Если у вас есть компонент, названный с
		маленькой буквы, присвойте его переменной, названной с большой буквы, перед тем как использовать его в JSX.</wg:p>

	<wg:p>К примеру, этот код не будет работать как ожидается:</wg:p>

	<ce:code-example-7/>

	<wg:p>Для того, чтобы это исправить, мы переименуем message в <code>Message</code> и станем
		использовать <code>&lt;Message/&gt;</code>, когда будем ссылаться на него:</wg:p>

	<ce:code-example-8/>

	<br/>
	<h3>3.1.1.4 Выбор типа во время выполнения</h3>

	<wg:p>Нельзя использовать выражение как тип React-элемента в JSX. Если вы
		всё же хотите использовать выражение, чтобы указать тип React-элемента,
		сперва назначьте его переменной, названной с большой буквы. Часто это подходит,
		когда вам необходимо отрисовать различные компоненты, в зависимости от свойств <code>prop</code>:</wg:p>

	<ce:code-example-9/>

	<wg:p>Для того, чтобы это исправить, мы должны предварительно
		присвоить тип переменной, названной с большой буквы:</wg:p>

	<ce:code-example-10/>

	<br/>
	<h2>3.1.2 Свойства props в JSX</h2>

	<wg:p>Существует несколько способов указать свойства в JSX.</wg:p>

	<br/>
	<h3>3.1.2.1 JavaScript выражения как свойства</h3>

	<wg:p>Вы можете передавать любые JavaScript-выражения как свойства,
		заключая их в <code>{}</code>. К примеру, в этом JSX:</wg:p>

	<ce:code-example-11/>

	<wg:p>Для <code>MyComponent</code>, значение props.foo будет равно 10,
		так как выражение 1 + 2 + 3 + 4 будет вычислено.</wg:p>

	<wg:p>Оператор <code>if</code> и цикл <code>for</code> не являются выражениями в JavaScript, поэтому
		они не могут быть использованы в JSX напрямую. Вместо этого, вы
		можете их в соседний код. К примеру:</wg:p>

	<ce:code-example-12/>

	<c:url var="conditionalRenderingUrl" value="/basics/conditional-rendering"/>
	<c:url var="listsAndKeysUrl" value="/basics/lists-and-keys"/>
	<wg:p>Вы можете изучить больше об <wg:link href="${conditionalRenderingUrl}">условной отрисовке</wg:link>
		и <wg:link href="${listsAndKeysUrl}">циклах</wg:link> в соответствующих разделах.</wg:p>

	<br/>
	<h3>3.1.2.2 Строковые литералы</h3>

	<wg:p>Вы можете передавать строковый литерал как свойство.
		Эти два JSX-выражения эквивалентны:</wg:p>

	<ce:code-example-13/>

	<wg:p>Когда вы передаёте строковый литерал, его значение не будет HTML
		экранированным (будет HTML-unescaped). Поэтому следующие два JSX-выражения эквивалентны:</wg:p>

	<ce:code-example-14/>

	<wg:p>Такое поведение не является релевантным. Оно здесь упомянуто только для полноты.</wg:p>

	<br/>
	<h3>3.1.2.3 Установка свойств по умолчанию в true</h3>

	<wg:p>Если вы не передаете значение в свойство, оно устанавливается по умолчанию в <code>true</code>.
		Следующие два JSX-выражения эквивалентны:</wg:p>

	<ce:code-example-15/>

	<wg:p>В большинстве случаев мы не рекомендуем использовать это, так как это можно спутать
		с объектным ES6 сокращением <code>{foo}</code>, который является сокращенной формой записи <code>{foo: foo}</code>,
		а не <code>{foo: true}</code>. Такое поведение существует просто для того, чтобы соответствовать поведению HTML.</wg:p>

	<br/>
	<h3>3.1.2.4 Spread – атрибуты</h3>

	<wg:p>Если у вас уже есть свойства в виде объекта, и вы ходите передать его в JSX, вы можете
		использовать "spread"-оператор <code>...</code> (троеточие), чтобы передать объект со свойствами целиком.
		Следующие два  компонента эквивалентны:</wg:p>

	<ce:code-example-16/>

	<wg:p>
		Вы также можете выбрать определенные свойства, которые ваш компонент будет использовать,
		передавая все остальные свойства с помощью оператора <code>...</code> .
	</wg:p>

	<ce:code-example-16.1/>

	<wg:p>
		В приведенном выше примере свойство type безопасно используется и не передается
		элементу &lt;button&gt; в DOM. Все остальные свойства передаются через <code>...other</code> объект, делающий данный
		компонент очень гибким. Вы можете видеть, что он передает свойства <code>onClick</code> и <code>children</code>.
	</wg:p>

	<wg:p>
		Spread-оператор может быть полезен, когда вы строите контейнеры общего назначения.
		Тем не менее, данный оператор также может сделать ваш код и более грязным,
		делая простым передачу множества необязательных свойств в компоненты, которые о них совсем
		не заботятся. Также он позволяет передавать недопустимые HTML-атрибуты в DOM. Рекомендуется
		использовать данный синтаксис разумно.
	</wg:p>

	<br/>
	<h2>3.1.3 Потомки в JSX</h2>

	<wg:p>В JSX-выражениях, которые содержат и открывающий, и закрывающий теги,
		содержание между этими тегами передается как специальное свойство: <code>props.children</code>.
		Существует несколько различных способов передать потомков:</wg:p>

	<br/>
	<h3>3.1.3.1 Строковые литералы</h3>

	<wg:p>Вы можете заключить строку между открывающим и закрывающим тегами, тогда
		свойство <code>props.children</code> будет равно этой строке. Это полезно для многих
		встроенных HTML элементов. К примеру:</wg:p>

	<ce:code-example-17/>

	<wg:p>Это валидный JSX, и свойство <code>props.children</code> в <code>MyComponent</code> будет просто
		строкой «Привет, мир!». HTML будет не экранирован, поэтому вы можете писать на
		JSX также, как если бы вы писали на обычном HTML:</wg:p>

	<ce:code-example-18/>

	<wg:p>JSX удаляет пробелы вначале и конце строки. Он также удаляет пустые строки.
		Новая строка, прилегающая к тегу будет удалена. Новые строки, находящиеся по середине
		строковых литералов, сжимаются в единичный пробел. Все это отрисуется в то же самое:</wg:p>

	<ce:code-example-19/>

	<br/>
	<h3>3.1.3.2 JSX-потомки</h3>

	<wg:p>Вы можете предоставить больше JSX-элементов в качестве потомков.
		Это полезно для отображения вложенных компонентов:</wg:p>

	<ce:code-example-20/>

	<wg:p>Вы можете смешивать различные типы потомков, то есть можете использовать строковые
		литералы вместе с JSX-потомками. Это другой способ, в котором JSX такой же, как HTML,
		поэтому данный код является и валидным JSX, и валидным HTML:</wg:p>

	<ce:code-example-21/>

	<wg:p><b>Начиная с 16 версии</b> React компонент может возвращать также и массив элементов:</wg:p>

	<ce:code-example-21.1/>

	<br/>
	<h3>3.1.3.3 JavaScript выражения как потомки</h3>

	<wg:p>Вы можете передавать любое JavaScript выражение как потомок,
		заключая его в <code>{}</code>. Например, эти выражения эквивалентны:</wg:p>

	<ce:code-example-22/>

	<wg:p>Это часто бывает полезным для отрисовки списка JSX-выражений произвольной
		длинны. Например, здесь отрисовывается HTML список:</wg:p>

	<ce:code-example-23/>

	<wg:p>JavaScript выражения могут быть смешаны с другими типами потомков.
		Это часто удобнее использовать, чем строковые шаблоны:</wg:p>

	<ce:code-example-24/>

	<br/>
	<h3>3.1.3.4 Функции как потомки</h3>

	<wg:p>Как правило JavaScript выражения, вставленные в JSX, будут приведены к строке,
		элементу React или списку этих вещей. Тем не менее, <code>props.children</code> работает точно
		также, как и любое другое свойство, так как в него можно передать любой вид данных,
		а не только тот вид, который React знает как отрисовать. Например, если у вас есть
		пользовательский компонент, вы могли бы передать функцию обратного вызова как <code>props.children</code>.</wg:p>

	<ce:code-example-25/>

	<wg:p>Потомки, переданные в пользовательский компонент, могут быть чем угодно, до тех
		пор пока компонент трансформирует их во что-нибудь, что React может понимать перед отрисовкой.
		Это не типичный случай использования и представлен только для того, чтобы вы познали, на что способен JSX. </wg:p>

	<br/>
	<h3>3.1.3.5 Booleans, Null и Undefined игнорируются</h3>

	<wg:p><code>false</code>, <code>null</code>, <code>undefined</code>, и <code>true</code> – валидные потомки,
		но они не отрисовываются. Эти JSX-выражения будут отрисованы одинаково:</wg:p>

	<ce:code-example-26/>

	<wg:p>Это может оказаться полезным, чтобы отрисовать элементы React по условию.
		Этот JSX отрисовывает <code>&lt;Modal /&gt;</code> только
		если <code>isModalShowed</code> имеет значение <code>true</code>:</wg:p>

	<ce:code-example-27/>

	<wg:p>Один нюанс заключается в том, что “ложные” значения, такие как число <code>0</code>,
		будут по-прежнему отрисовываться React. К примеру, данный код будет вести себя не так,
		как вы могли ожидать, так как будет отрисован <code>0</code>, когда <code>props.users</code> является пустым массивом:</wg:p>

	<ce:code-example-28/>

	<wg:p>Чтобы это исправить, убедитесь, что выражение перед
		<code>&&</code> всегда является <code>boolean</code>:</wg:p>

	<ce:code-example-29/>

	<wg:p>И напротив, если вам нужно значение, такое как <code>false</code>,
		<code>true</code>, <code>null</code>, или <code>undefined</code>, чтобы
		вывести его, то тогда вы сперва должны
		<wg:link href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String#String_conversion">конвертировать его в строку</wg:link>:</wg:p>

	<ce:code-example-30/>

</lt:layout>

<c:url var="prevPageUrl" value="/basics/topics"/>
<c:url var="nextPageUrl" value="typechecking-with-prop-types"/>
<app:page-navigate prevPageUrl="${prevPageUrl}"
                   pageStartAncor="pageStart"
                   nextPageUrl="${nextPageUrl}"/>