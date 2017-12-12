import React from "react"
import ReactDOM from 'react-dom'
import PropTypes from "prop-types"
class ManyToManyDisplayedField extends React.Component {
  render () {
    var opts = {};
    if (this.props.title) {
      opts['title'] = this.props.title;
    }
    opts['data-displayed_field'] = true;
    return (
      <span {...opts}>{this.props.text}</span>
    );
  }
}

ManyToManyDisplayedField.propTypes = {
  title: PropTypes.string,
  text: PropTypes.string
};
export default ManyToManyDisplayedField
