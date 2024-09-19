import nimQt
import webkit2

type
  TabManager* = ref object
    widget*: QTabWidget
    tabs: seq[QWebView]

proc newTabManager*(parent: QWidget): TabManager =
  result = TabManager()
  result.widget = newQTabWidget(parent)
  result.tabs = @[]

  result.widget.tabCloseRequested.connect(proc(index: int) =
    result.widget.removeTab(index)
    result.tabs.delete(index)
  )

proc addTab*(self: TabManager, url: string = "about:blank") =
  var webView = newQWebView(self.widget)
  webView.load(url)
  self.tabs.add(webView)
  discard self.widget.addTab(webView, "New Tab")

proc loadUrl*(self: TabManager, url: string) =
  let currentIndex = self.widget.currentIndex
  if currentIndex >= 0:
    self.tabs[currentIndex].load(url)
  else:
    self.addTab(url)