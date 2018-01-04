import React from "react"
import PropTypes from "prop-types"
class QuietLink extends React.Component {
  render () {
    return (
      <a href={this.props.url} className="quiet" title={this.props.popupText}>{this.props.txt}</a>
    );
  }
}

QuietLink.propTypes = {
  txt: PropTypes.string,
  url: PropTypes.string,
  popupText: PropTypes.string
};
export default QuietLink
