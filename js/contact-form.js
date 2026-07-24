(function () {
  var form = document.querySelector(".contact-form[data-mailto]");

  if (!form) {
    return;
  }

  form.addEventListener("submit", function (event) {
    event.preventDefault();

    var data = new FormData(form);

    if (data.get("_gotcha")) {
      return;
    }

    var recipient = form.getAttribute("data-mailto");
    var baseSubject = form.getAttribute("data-mail-subject") || "Contato pelo site";
    var subjectText = (data.get("assunto") || "").trim();
    var subject = subjectText ? baseSubject + ": " + subjectText : baseSubject;
    var fields = [
      ["Nome", "nome"],
      ["E-mail", "email"],
      ["Telefone", "telefone"],
      ["Assunto", "assunto"],
      ["Localização", "localizacao"],
      ["Descrição", "descricao"]
    ];
    var body = fields
      .map(function (field) {
        var value = (data.get(field[1]) || "").trim();
        return value ? field[0] + ": " + value : "";
      })
      .filter(Boolean)
      .join("\n");

    window.location.href = "mailto:" + encodeURIComponent(recipient) +
      "?subject=" + encodeURIComponent(subject) +
      "&body=" + encodeURIComponent(body);
  });
}());
