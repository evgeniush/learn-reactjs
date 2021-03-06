<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="lt" tagdir="/WEB-INF/tags/layout" %>
<%@taglib prefix="wg" tagdir="/WEB-INF/tags/widget" %>
<%@taglib prefix="ce" tagdir="/WEB-INF/tags/application/updates/domAttributesInReact16" %>
<%@taglib prefix="app" tagdir="/WEB-INF/tags/application" %>

<a name="pageStart"></a>
<lt:layout cssClass="black-line"/>
<lt:layout cssClass="page react-v16.0-page">
    <h1>DOM-атрибуты в React 16</h1>

    <wg:p><b>8 Сентября, 2017. Dan Abramov(Дэн Абрамов)</b></wg:p>

    <wg:p>В прошлом React игнорировал неизвестные DOM-атрибуты. Если бы вы написали JSX с
        атрибутом, который React не распознает, React бы просто пропустил его. Например, данный код:</wg:p>

    <ce:code-example-1/>

    <wg:p>в React 15 стал бы в результате пустым div в DOM:</wg:p>

    <ce:code-example-2/>

    <wg:p>В React 16 мы вносим изменения. Теперь любые неизвестные атрибуты попадут в DOM:</wg:p>

    <ce:code-example-3/>

    <h2>Почему мы делаем эти изменения?</h2>

    <wg:p>React всегда предоставляет JavaScript-ориентированный API для DOM.
        Поскольку компоненты React часто принимают как пользовательские, так и
        связанные с DOM свойства, для React имеет смысл использовать верблюжью
        нотацию также как DOM API:</wg:p>

    <ce:code-example-4/>

    <wg:p>Здесь ничего не изменилось. Однако способ, каким мы достигали этого в прошлом,
        заставлял нас хранить список всех допустимых атрибутов React DOM в бандле:</wg:p>

    <ce:code-example-5/>

    <wg:p>Это имело два недостатка:</wg:p>

    <wg:p>
        <ul>
            <li>Вы не могли передать пользовательский атрибут. А такая возможность полезна
                для предоставления нестандартных, специфических для браузера атрибутов, использования
                новых DOM API и интеграции с упрямыми сторонними библиотеками.</li>
            <li>Список атрибутов продолжал расти с течением времени, но большинство канонических
                имен атрибутов React уже валидны в DOM. Удаление большей части списка помогло нам
                немного уменьшить размер бандла.</li>
        </ul>
    </wg:p>

    <wg:p>С новым подходом обе эти проблемы были решены. В React 16 вы можете передавать пользовательские
        атрибуты всем элементам HTML и SVG, а React не нужно включать весь список
        атрибутов в <code>production</code> версию.</wg:p>

    <wg:p><b>Обратите внимание, что вы все равно должны использовать каноническое  React
        именование для известных атрибутов:</b></wg:p>

    <ce:code-example-6/>
    <ce:code-example-7/>

    <wg:p>Другими словами, способ использования компонентов DOM в React не изменился,
        но теперь у вас есть новые возможности.</wg:p>


    <h2>Могу ли я хранить данные в пользовательских атрибутах?</h2>

    <wg:p>Нет. Мы не рекомендуем хранить данные в атрибутах DOM. Даже если
        вам нужно, <code>data-</code> атрибуты, вероятно, являются лучшим подходом, но в
        большинстве случаев данные должны храниться в состоянии React
        компонента или внешних хранилищах.</wg:p>

    <wg:p>Однако новая возможность удобна, если вам нужно использовать нестандартный
        или новый атрибут DOM, или если вам нужно интегрироваться с сторонней библиотекой,
        которая полагается на такие атрибуты.</wg:p>

    <h2>Data и ARIA атрибуты</h2>

    <wg:p>Как и раньше, React позволяет вам свободно передавать <code>data-</code> и
        <code>aria-</code> атрибуты:</wg:p>

    <ce:code-example-8/>

    <wg:p>Это поведение не изменилось.</wg:p>

    <wg:p>Понятность очень важна, поэтому, несмотря на то, что React 16 передает
        любые атрибуты, он все еще проверяет, чтобы <code>aria-</code> свойства имели
        правильные имена в режиме разработки, как это делал React 15.</wg:p>

    <h2>Путь миграции</h2>

    <wg:p>Мы включили предупреждение об неизвестных атрибутах, начиная с
        React 15.2.0, который вышел более года назад. Подавляющее большинство
        сторонних библиотек уже обновили свой код. Если ваше приложение на React
        15.2.0 или выше не создает предупреждений, это изменение не требует модификаций в вашем коде.</wg:p>

    <wg:p>Если вы по-прежнему где-то случайно передаете не-DOM атрибуты DOM компонентам,
        в React 16 вы начнете видеть эти атрибуты в DOM, например:</wg:p>

    <ce:code-example-9/>

    <wg:p>Это отчасти безопасно (браузер просто игнорирует такие атрибуты), но
        мы рекомендуем избавлять код от таких случаев. Одна потенциальная опасность
        заключается в том, что если вы передаете объект, который реализует собственный
        <code>toString ()</code> или <code>valueOf ()</code> метод – он выдаст исключение. Другая возможная
        проблема заключается в том, что теперь устаревшие атрибуты HTML, такие
        как <code>align</code> и <code>valign</code>, будут переданы в DOM. Раньше они удалялись,
        потому что React их не поддерживал.</wg:p>

    <wg:p>Чтобы избежать этих проблем, мы рекомендуем исправить предупреждения, которые вы видите в
        React 15, перед обновлением до React 16.</wg:p>

    <h2>Более подробно об изменениях</h2>

    <wg:p>Мы внесли несколько других изменений, чтобы сделать поведение более предсказуемым и
        помочь вам избежать ошибок. Мы не ожидаем, что эти изменения нарушат работу существующих приложений.</wg:p>

    <wg:p><b>Эти изменения влияют только на компоненты DOM, такие как &lt;div&gt;, а не
        на ваши собственные компоненты.</b></wg:p>

    <wg:p>Ниже приведен их подробный список.</wg:p>

    <wg:p>
        <ul>
            <li><b>Неизвестные атрибуты со строками, цифрами и объектами:</b>
                <ce:code-example-10/>
                <div><b>React 15</b>: Предупреждает и игнорирует их.</div>
                <div><b>React 16</b>: Преобразует значения в строки и передает их.</div>
                <div><i><b>Примечание</b>: атрибуты, начинающиеся с <code>on</code>, не передаются как исключение,
                    поскольку это может стать потенциальной дырой в безопасности.</i></div>
            </li>
            <br/>
            <li><b>Известные атрибуты с отличным каноническим React именем:</b>
                <ce:code-example-11/>
                <div><b>React 15</b>: Предупреждает и игнорирует их.</div>
                <div><b>React 16</b>: Предупреждает, но преобразует значения в строки и передает их.</div>
                <div><i><b>Примечание</b>: всегда используйте каноническое React именование для всех поддерживаемых атрибутов.</i></div>
            </li>
            <br/>
            <li><b>Небулевые атрибуты с булевыми значениями:</b>
                <ce:code-example-12/>
                <div><b>React 15</b>: Преобразует булевы значения в строки и передает их.</div>
                <div><b>React 16</b>: Предупреждает и игнорирует их.</div>
            </li>
            <br/>
            <li><b>Несобытийные атрибуты со значениями типа <code>Function</code>:</b>
                <ce:code-example-13/>
                <div><b>React 15</b>: Преобразует функции в строки и передает их.</div>
                <div><b>React 16</b>: Предупреждает и игнорирует их.</div>
            </li>
            <br/>
            <li><b>Атрибуты со значениями типа <code>Symbol</code>:</b>
                <ce:code-example-14/>
                <div><b>React 15</b>: Ломается.</div>
                <div><b>React 16</b>: Предупреждает и игнорирует их.</div>
            </li>
            <br/>
            <li><b>Атрибуты с значениями <code>NaN</code>:</b>
                <ce:code-example-15/>
                <div><b>React 15</b>: Преобразует <code>NaN</code> в строке и передает ее.</div>
                <div><b>React 16</b>: Преобразует <code>NaN</code> в строку и передает ее с предупреждением.</div>
            </li>
        </ul>
    </wg:p>

    <wg:p>При тестировании этого релиза мы также создали автоматически генерируемую таблицу для
        всех известных атрибутов, чтобы отслеживать потенциальные регрессии.</wg:p>

    <h2>Попробуйте это!</h2>

    <wg:p>Вы можете попробовать эти изменения на
        <wg:link href="https://codepen.io/gaearon/pen/gxNVdP?editors=0010">CodePen</wg:link>.</wg:p>

    <wg:p>Он использует React 16 RC. Вы также можете помочь нам в тестировании используя RC в вашем проекте!</wg:p>

    <h2>Благодарности</h2>

    <wg:p>Большая работа была проделана Натаном Хунзакером, который был плодотворным внешним контрибьютором React.</wg:p>

    <wg:p>Вы можете найти его работу над данной проблемой в нескольких PR в течение
        прошлого года: <b>#6459</b>, <b>#7311</b>, <b>#10229</b>, <b>#10397</b>, <b>#10385</b> и <b>#10470</b>.</wg:p>

    <wg:p>Значительные изменения в популярном проекте могут занять много времени и
        исследований. Натан продемонстрировал настойчивость и решимость добиться этих
        изменений, и мы очень благодарны ему за эти и другие усилия.</wg:p>

    <wg:p>Мы также хотели бы поблагодарить Брэндона Дайла и Джейсона Куэнса
        за их неоценимую помощь в поддержке React в этом году.</wg:p>

    <h2>Предстоящая работа</h2>

    <wg:p>Мы не изменяем работу пользовательских элементов в React 16, но существуют
        дискуссии об установке свойств вместо атрибутов, и мы можем пересмотреть это в
        React 17. Не стесняйтесь присоединиться, если вы хотите помочь!</wg:p>
</lt:layout>

<c:url var="prevPageUrl" value="react_v16_0"/>
<c:url var="nextPageUrl" value="error-handling-in-react-16"/>
<app:page-navigate pageStartAncor="pageStart"
                   prevPageUrl="${prevPageUrl}"
                   nextPageUrl="${nextPageUrl}"/>