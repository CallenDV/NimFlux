import nimQt
import tabmanager

type
  UrlBar* = ref object
    widget*: QLineEdit
    tabManager: TabManager

proc newUrlBar*(parent: QWidget, tabManager: TabManager): UrlBar =
  result = UrlBar()
  result.widget = newQLineEdit(parent)
  result.tabManager = tabManager

  result.widget.returnPressed.connect(proc() =
    let url = result.widget.text
    result.tabManager.loadUrl(url)
  )

proc updateUrl*(self: UrlBar, url: string) =
  self.widget.setText(url)