<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="lt" tagdir="/WEB-INF/tags/layout" %>
<%@taglib prefix="wg" tagdir="/WEB-INF/tags/widget" %>
<%@taglib prefix="app" tagdir="/WEB-INF/tags/application" %>
<%@taglib prefix="rf" tagdir="/WEB-INF/tags/application/reference" %>
<%@taglib prefix="ce" tagdir="/WEB-INF/tags/application/reference/react-dom" %>

<lt:layout cssClass="page hello-world-example-page">
	<wg:head size="3"><b>4.3 ReactDOM</b></wg:head>

	<wg:p>Если вы загружаете React c помощью тега <code>&lt;script&gt;</code>, эти API верхнего уровня
		доступны в глобальном <code>ReactDOM</code>. Если вы используете ES6 с <b>npm</b>, вы можете
		написать <code>import ReactDOM from 'react-dom'</code>. Если вы используете ES5 с <b>npm</b>, вы
		можете написать <code>var ReactDOM = require ('react -dom')</code>.</wg:p>

	<br/>
	<wg:head size="4"><b>4.3.1 Обзор</b></wg:head>

	<wg:p>Пакет react-dom предоставляет методы, специфичные для DOM,
		которые можно использовать на верхнем уровне вашего приложения и в качестве
		аварийного люка, чтобы выйти за пределы модели React, если это необходимо.
		Большинству ваших компонентов не нужно использовать этот модуль.</wg:p>

	<wg:p>
		<ul>
			<li>render()</li>
			<li>unmountComponentAtNode()</li>
			<li>findDOMNode()</li>
		</ul>
	</wg:p>

	<br/>
	<wg:head size="4"><b>4.3.2 Поддержка браузерами</b></wg:head>

	<wg:p>React поддерживает все популярные браузеры, включая Internet Explorer 9 и выше.</wg:p>

	<app:alert title="Замечание.">
		Не поддерживаются старые браузеры, которые не поддерживают методы ES5, но ваши
		приложения могут работать в старых браузерах, если на страницу включены полифилы,
		такие как <b>es5-shim</b> и <b>es5-sham</b>. Вы сами по себе, если решите пойти по этому пути.
	</app:alert>

	<br/>
	<wg:head size="4"><b>4.3.3 Справка</b></wg:head>

	<rf:definition title="render()">
		<ce:code-example-1/>

		<wg:p>Отрисовывает элемент React в DOM в предоставленом <code>container</code> и вернёт ссылку
			на компонент (или возвращает значение <code>null</code> для компонентов без состояния).</wg:p>

		<wg:p>Если элемент React ранее был отрисован в <code>container</code>, то на нем выполнится
			обновление и DOM изменится только при необходимости, чтобы отобразить
			актуальный элемент React.</wg:p>

		<wg:p>Если предоставляется дополнительный коллбэк, он будет выполнен
			после отрисовки или обновления компонента.</wg:p>
	</rf:definition>

	<app:alert title="Замечание.">
		<wg:p><code>ReactDOM.render()</code> управляет содержимым узла контейнера, который вы
			передали. Любые существующие элементы DOM внутри заменяются при первом
			вызове. В последующих вызовах используется эффективный React алгоритм
			сравнения DOM для эффективного обновления.</wg:p>

		<wg:p><code>ReactDOM.render()</code> не изменяет узел контейнера (только модифицирует
			дочерние элементы контейнера). Возможно вставить компонент в существующий
			узел DOM без перезаписи существующих дочерних элементов.</wg:p>

		<wg:p><code>ReactDOM.render()</code> в настоящий момент возвращает ссылку на корневой
			экземпляр <code>ReactComponent</code>. Однако использование этого возвращаемого значения
			является устаревшим и его следует избегать, поскольку будущие версии React
			в некоторых случаях могут отрисовывать компоненты асинхронно. Если вам
			нужна ссылка на экземпляр ковневого <code>ReactComponent</code>, предпочтительным
			решением является привязка коллбэка <code>ref</code> к корневому элементу.</wg:p>
	</app:alert>

	<rf:definition title="unmountComponentAtNode()">
		<ce:code-example-2/>

		Удаляет установленный компонент React из DOM и очищает его обработчики событий и
		состояние. Если компонент не был монтирован в контейнер, вызов этой функции ничего
		не делает. Возвращает <code>true</code>, если компонент был демонтирован и <code>false</code>, если не
		найдено компонента для демонтирования.
	</rf:definition>

	<rf:definition title="findDOMNode()">
		<ce:code-example-3/>

		Если компонент был монтирован в DOM, этот метод возвращает соответствующий нативный
		элемент DOM браузера. Этот метод полезен для считывания значений из DOM, таких как
		значения полей формы и выполнения измерений DOM. <b>В большинстве случаев вы можете
		прикреплять ссылку <code>ref</code> на узел DOM и избегать использования</b> <code>findDOMNode</code>. Когда
		render возвращает <code>null</code> или <code>false</code>, <code>findDOMNode</code>
		возвращает значение <code>null</code>.
	</rf:definition>

	<app:alert title="Замечание.">
		<wg:p><code>findDOMNode</code> - это аварийный люк, используемый для доступа к основному узлу DOM.
			В большинстве случаев его использование не рекомендуется, поскольку он нарушает
			абстракцию компонента.</wg:p>

		<wg:p><code>findDOMNode</code> работает только на монтированных компонентах (то есть на компонентах,
			помещенных в DOM). Если вы попытаетесь вызвать его для компонента, который еще не
			был монтирован (например, вызов метода <code>findDOMNode()</code> в <code>render()</code> для компонента,
			который еще предстоит создать), будет выброшено исключение.</wg:p>

		<wg:p><code>findDOMNode</code> не может использоваться на функциональных компонентах.</wg:p>
	</app:alert>

</lt:layout>