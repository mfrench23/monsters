import React from "react"
import ReactDOM from 'react-dom'
import PropTypes from "prop-types"
class HiddenField extends React.Component {
  render () {
    var opts = {};
    opts['id'] = this.props.identifier;
    opts['name'] = this.props.identifier;
    opts['value'] = this.props.val;
    return (
      <input type="hidden" {...opts} />
    );
  }
}

HiddenField.propTypes = {
  identifier: PropTypes.string,
  val: PropTypes.string
};
export default HiddenField
