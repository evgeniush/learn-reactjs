<%@ tag pageEncoding="UTF-8" %>
<%@ include file="../../../baseAttr.tag" %>
<%@taglib prefix="cd" tagdir="/WEB-INF/tags/application/code" %>

<%@ attribute name="cssClass" required="false" rtexprvalue="true" %>
<%@ attribute name="name" required="false" rtexprvalue="true" %>
<%@ attribute name="id" required="false" rtexprvalue="true" %>
<%@ attribute name="codePenUrl" required="false" rtexprvalue="true" %>

<cd:code-example-decorator codePenUrl="${codePenUrl}">
    <pre class="prettyprint">
        <code class="language-javascript">
  const users = props.users;
    return (
      &lt;ul&gt;
        <cd:hl>{users.map((user) =&gt; &lt;UserItem user={user}/&gt;;)}</cd:hl>
      &lt;/ul&gt;
    );
  }</code>
    </pre>
</cd:code-example-decorator>