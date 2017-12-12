import React from "react"
import ReactDOM from 'react-dom'
import PropTypes from "prop-types"
class ManyToManySubheaderSpan extends React.Component {
  render () {
    if(this.props.subheader) {
      return (
        <span>{this.props.subheader}</span>
      );
    } else {
      return (
        <span class="footnote">(n/a) </span>
      );
    }
  }
}

ManyToManySubheaderSpan.propTypes = {
  subheader: PropTypes.string
};
export default ManyToManySubheaderSpan
