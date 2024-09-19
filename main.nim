import nimQt
import webkit2
import os

import urlbar
import tabmanager
import settings

type
  Browser = ref object
    window: QMainWindow
    tabManager: TabManager
    urlBar: UrlBar
    settings: Settings

proc createBrowser(): Browser =
  result = Browser()
  result.window = newQMainWindow()
  result.window.resize(1024, 768)
  result.window.setWindowTitle("Nim Web Browser")

  result.tabManager = newTabManager(result.window)
  result.urlBar = newUrlBar(result.window, result.tabManager)
  result.settings = newSettings()

  var layout = newQVBoxLayout()
  layout.addWidget(result.urlBar.widget)
  layout.addWidget(result.tabManager.widget)

  var centralWidget = newQWidget()
  centralWidget.setLayout(layout)
  result.window.setCentralWidget(centralWidget)

proc main() =
  var app = newQApplication()
  var browser = createBrowser()
  browser.window.show()
  app.exec()

when isMainModule:
  main()