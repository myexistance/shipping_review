import React from 'react'
import { Route, Switch } from 'react-router-dom'
import Shippings from './Shippings/Shippings'
import Shipping from './Shipping/Shipping'


const App = () => {
          return (
          <Switch>
                    <Route exact path="/" component={Shippings}/>
                    <Route exact path="/shippings/:slug" component={Shipping}/>
          </Switch>
          )
}

export default App